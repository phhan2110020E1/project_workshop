package com.workshop.dao;

import com.google.cloud.storage.*;

import com.google.firebase.FirebaseApp;
import com.workshop.config.QRCodeGenerator;
import com.workshop.config.cloud.ObjContent;
import com.workshop.config.cloud.ResponseRequestOptions;
import com.workshop.dto.RequestDTO.RequestDTO;
import com.workshop.dto.RequestResponse;
import com.workshop.model.*;
import com.workshop.model.courseModel.Course;
import com.workshop.model.courseModel.QrToken;
import com.workshop.model.userModel.User;
import com.workshop.repositories.*;
import com.workshop.repositories.Course.CourseDiscountRepository;
import com.workshop.repositories.Course.CourseRepository;
import com.workshop.repositories.Course.QrCodeTickerRepository;
import com.workshop.repositories.User.UserRepository;
import com.workshop.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URL;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

import com.google.firebase.cloud.StorageClient;

import javax.imageio.ImageIO;


@Service
@RequiredArgsConstructor
public class RequestServiceImpl implements RequestService {
    private final RequestRepository requestRepository;
    private final UserService userService;
    private final UserRepository userRepository;
    private final TransactionRepository transactionRepository;
    private final PaymentRepository paymentRepository;
    private final CourseRepository courseRepository;
    private final CourseDiscountRepository courseDiscountRepository;
    private final QrCodeTickerRepository qrCodeTickerRepository;
    private final QRCodeGenerator qrCodeGenerator;
    private final FirebaseApp firebaseApp;

    @Override
    public List<RequestResponse> ListRequest() {
        List<Request> requestList = requestRepository.findAll();
        List<RequestResponse> requestResponseList = new ArrayList<>();
        for (Request request : requestList) {
            RequestResponse requestResponse = new RequestResponse();

            if (request.getCourses() != null) {
                requestResponse.setWorkshopName(request.getCourses().getName());
                requestResponse.setWorkshopId(request.getCourses().getId());
            }
            if (request.getLocation() != null) {
                requestResponse.setLocationId(request.getLocation().getId());
                requestResponse.setLocationName(request.getLocation().getName());
            }
            requestResponse.setId(request.getId()).setValue(request.getValue())
                    .setStatus(String.valueOf(request.getStatus()))
                    .setType(String.valueOf(request.getType()))
                    .setUserId(request.getUser().getId()).setUserName(request.getUser().getUser_name())
                    .setRegistrationDateTime(request.getCreatedDate().toLocalDateTime());
            requestResponseList.add(requestResponse);
        }
        return requestResponseList;
    }

    @Override
    public ResponseRequestOptions createRequestOptions(RequestDTO requestDTO) {
        try {
            User user = userService.getCurrentUserDetails();
            Request request = new Request();
            Transaction transaction = new Transaction();
            PaymentMethod paymentMethod = new PaymentMethod();
            Course course = new Course();
            ResponseRequestOptions responseRequestOptions = new ResponseRequestOptions();
            switch (requestDTO.getType()) {
                case "DEPOSIT":

                    responseRequestOptions = (handleDepositRequest(user, requestDTO, request, transaction, paymentMethod));
                    break;
                case "WITHDRAW":
                    responseRequestOptions = (CheckWithDrawRequest(requestDTO, request, transaction, paymentMethod));
                    break;
                case "HANDLE_WITHDRAW":
                    responseRequestOptions = (handleWithDrawRequest(user, requestDTO, request));
                    break;
                case "BUY_COURSE":
                    responseRequestOptions = (handleBuyCourseRequest(user, requestDTO, request, transaction, paymentMethod, course));
                    break;
                default:
                    break;
            }
            return responseRequestOptions;
        } catch (Exception e) {
            // Handle exceptions
            return null;
        }
    }

    @Override
    public boolean changeStatusRequest(Long request_id) {
        return false;
    }

    private ResponseRequestOptions handleWithDrawRequest(User user, RequestDTO requestDTO, Request request) {
        if (requestDTO.getAmount() < user.getBalance() && (user.getBalance() - requestDTO.getAmount()) > 10) {
            request.setValue(requestDTO.getAmount()).setUser(user).setStatus(Request.RequestStatus.PENDING).setType(Request.RequestType.valueOf(requestDTO.getType()));
            requestRepository.save(request);
            ResponseRequestOptions responseRequestOptions = new ResponseRequestOptions();
            responseRequestOptions.setStatus("PENDING");
            return responseRequestOptions;
        } else {
            request.setUser(user).setStatus(Request.RequestStatus.REJECTED).setType(Request.RequestType.valueOf(requestDTO.getType()));
            requestRepository.save(request);

            ResponseRequestOptions responseRequestOptions = new ResponseRequestOptions();
            responseRequestOptions.setStatus("REJECTED");
            return responseRequestOptions;
        }
    }

    private ResponseRequestOptions handleDepositRequest(User user, RequestDTO requestDTO, Request request, Transaction transaction, PaymentMethod paymentMethod) {
        if (requestDTO.getPaymentStatus().equals("success") && requestDTO.getAmount() > 0) {
            request.setUser(user).setStatus(Request.RequestStatus.APPROVED).setType(Request.RequestType.valueOf(requestDTO.getType()));
            paymentMethod.setDescription(requestDTO.getType()).setName(requestDTO.getPaymentName());
            Double newBalance = user.getBalance() + requestDTO.getAmount();
            Long id = user.getId();
            paymentRepository.save(paymentMethod);
            userRepository.updateBalanceAccountById(id, newBalance);
            requestRepository.save(request);
            transaction.setRequest(request).setUser(user).setPaymentMethod(paymentMethod)
                    .setAmount(requestDTO.getAmount())
                    .setType(Transaction.Type.valueOf(requestDTO.getType()))
                    .setStatus(Transaction.Status.COMPLETED)
                    .setTransactionDate(LocalDateTime.now());
            transactionRepository.save(transaction);
            ResponseRequestOptions responseRequestOptions = new ResponseRequestOptions();
            responseRequestOptions.setStatus("APPROVED");
            return responseRequestOptions;
        } else if (requestDTO.getPaymentStatus().equals("pending") && requestDTO.getAmount() > 0) {
            request.setUser(user).setStatus(Request.RequestStatus.PENDING).setType(Request.RequestType.valueOf(requestDTO.getType()));
            paymentMethod.setDescription(requestDTO.getType()).setName(requestDTO.getPaymentName());
            paymentRepository.save(paymentMethod);
            requestRepository.save(request);
            transaction.setRequest(request).setUser(user).setPaymentMethod(paymentMethod)
                    .setAmount(requestDTO.getAmount())
                    .setType(Transaction.Type.valueOf(requestDTO.getType()))
                    .setStatus(Transaction.Status.PENDING)
                    .setTransactionDate(LocalDateTime.now());
            transactionRepository.save(transaction);
            ResponseRequestOptions responseRequestOptions = new ResponseRequestOptions();
            responseRequestOptions.setStatus("PENDING");
            return responseRequestOptions;
        } else {
            request.setUser(user).setStatus(Request.RequestStatus.REJECTED).setType(Request.RequestType.valueOf(requestDTO.getType()));
            paymentMethod.setDescription(requestDTO.getType()).setName(requestDTO.getPaymentName());
            paymentRepository.save(paymentMethod);
            requestRepository.save(request);
            transaction.setRequest(request).setUser(user).setPaymentMethod(paymentMethod)
                    .setAmount(requestDTO.getAmount())
                    .setType(Transaction.Type.valueOf(requestDTO.getType()))
                    .setStatus(Transaction.Status.FAILED)
                    .setTransactionDate(LocalDateTime.now());
            transactionRepository.save(transaction);

            ResponseRequestOptions responseRequestOptions = new ResponseRequestOptions();
            responseRequestOptions.setStatus("REJECTED");
            return responseRequestOptions;
        }
    }

    private ResponseRequestOptions CheckWithDrawRequest(RequestDTO requestDTO, Request request, Transaction transaction, PaymentMethod paymentMethod) {
        Long teacher_id = requestDTO.getItem_register_id();
        Optional<User> TeacherOption = userRepository.findById(teacher_id);
        Long request_id = requestDTO.getRequestId();
        Optional<Request> requestOption = requestRepository.findById(request_id);
        if (TeacherOption.isPresent() && requestOption.isPresent()) {
            User Teacher = TeacherOption.get();
            Request requestExit = requestOption.get();
            if (requestExit.getValue() < Teacher.getBalance() && (Teacher.getBalance() - requestExit.getValue()) > 10)
            {
//                request.setUser(Teacher).setStatus(Request.RequestStatus.APPROVED).setType(Request.RequestType.valueOf(requestDTO.getType()));

                requestRepository.updateRequestStatusById(requestDTO.getRequestId(),Request.RequestStatus.APPROVED);
                paymentMethod.setDescription(requestDTO.getType()).setName(requestDTO.getPaymentName());
                Double newBalance = Teacher.getBalance() - requestExit.getValue();
                Long id = Teacher.getId();
                paymentRepository.save(paymentMethod);
                userRepository.updateBalanceAccountById(id, newBalance);
                transaction.setRequest(requestExit).setUser(Teacher).setPaymentMethod(paymentMethod)
                        .setAmount(requestExit.getValue())
                        .setType(Transaction.Type.valueOf(requestDTO.getType()))
                        .setStatus(Transaction.Status.COMPLETED)
                        .setTransactionDate(LocalDateTime.now());
                transactionRepository.save(transaction);
                ResponseRequestOptions responseRequestOptions = new ResponseRequestOptions();
                responseRequestOptions.setStatus("APPROVED");
                return responseRequestOptions;
            } else if (requestExit.getValue() < Teacher.getBalance() && (Teacher.getBalance() - requestExit.getValue()) < 10) {
                requestRepository.updateRequestStatusById(requestDTO.getRequestId(),Request.RequestStatus.REJECTED);
                paymentMethod.setDescription(requestDTO.getType()).setName(requestDTO.getPaymentName());
                paymentRepository.save(paymentMethod);
                transaction.setRequest(requestExit).setUser(Teacher).setPaymentMethod(paymentMethod)
                        .setAmount(requestExit.getValue())
                        .setType(Transaction.Type.valueOf(requestDTO.getType()))
                        .setStatus(Transaction.Status.CANCELED)
                        .setTransactionDate(LocalDateTime.now());
                transactionRepository.save(transaction);
                ResponseRequestOptions responseRequestOptions = new ResponseRequestOptions();
                responseRequestOptions.setStatus("REJECTED");
                return responseRequestOptions;
            } else {
                requestRepository.updateRequestStatusById(requestDTO.getRequestId(),Request.RequestStatus.CANCEL);
                paymentMethod.setDescription(requestDTO.getType()).setName(requestDTO.getPaymentName());
                paymentRepository.save(paymentMethod);
                requestRepository.save(request);
                transaction.setRequest(requestExit).setUser(Teacher).setPaymentMethod(paymentMethod)
                        .setAmount(requestExit.getValue())
                        .setType(Transaction.Type.valueOf(requestDTO.getType()))
                        .setStatus(Transaction.Status.FAILED)
                        .setTransactionDate(LocalDateTime.now());
                transactionRepository.save(transaction);
                ResponseRequestOptions responseRequestOptions = new ResponseRequestOptions();
                responseRequestOptions.setStatus("CANCEL");
                return responseRequestOptions;
            }
        } else {
            ResponseRequestOptions responseRequestOptions = new ResponseRequestOptions();
            responseRequestOptions.setStatus("CANCEL");
            return responseRequestOptions;

        }
    }
    private ResponseRequestOptions handleBuyCourseRequest(User user, RequestDTO requestDTO, Request request, Transaction transaction, PaymentMethod paymentMethod, Course course) {
        try {
            Optional<Course> courseOp = courseRepository.findById(requestDTO.getItem_register_id());
            if (courseOp.isPresent() && courseOp.get().isPublic()) {
                course = courseOp.get();
                final double transactionFees = 0.03;
                request.setUser(user).setStatus(Request.RequestStatus.APPROVED).setType(Request.RequestType.valueOf(requestDTO.getType())).setCourses(course);
                paymentMethod.setDescription(requestDTO.getType()).setName(requestDTO.getPaymentName());
                transaction.setRequest(request).setUser(user).setPaymentMethod(paymentMethod)
                        .setAmount(requestDTO.getAmount())
                        .setType(Transaction.Type.valueOf(requestDTO.getType()))
                        .setStatus(Transaction.Status.COMPLETED)
                        .setTransactionDate(LocalDateTime.now());
                Long TeacherId = course.getTeacher().getId();
                User teacher = userRepository.findById(TeacherId).orElse(null);
                User Admin = userRepository.findByEmail("lactuong64@gmail.com").orElse(null);
                assert Admin != null;
                Long AdminId = Admin.getId();
                Long StudentId = user.getId();
                Double discountAmount = requestDTO.getDiscountAmount();
                Double dtoAmount = requestDTO.getAmount();
                Double AmountAfterDiscount = 0.0;
                Double newBalanceForTeacher = 0.0;
                Double newBalanceForAdmin = 0.0;
                Double newBalanceForStudent = 0.0;
                if (requestDTO.getStatus().equals("payment_gateway")) {
                    if (discountAmount > 0 && dtoAmount > discountAmount && requestDTO.getDiscountCode() != null) {
                        AmountAfterDiscount = Math.max(0, dtoAmount - discountAmount);
                        BigDecimal transactionFee = BigDecimal.valueOf(transactionFees).multiply(BigDecimal.valueOf(AmountAfterDiscount));
                        transactionFee = transactionFee.setScale(2, RoundingMode.HALF_UP);
                        newBalanceForTeacher = teacher.getBalance() + AmountAfterDiscount - transactionFee.doubleValue();
                        newBalanceForAdmin = Admin.getBalance() + transactionFee.doubleValue();
                    } else {
                        Double transactionFee = transactionFees * requestDTO.getAmount();
                        newBalanceForTeacher = teacher.getBalance() + requestDTO.getAmount() - transactionFee;
                        newBalanceForAdmin = Admin.getBalance() + transactionFee;
                    }
                } else {
                    if (discountAmount > 0 && dtoAmount > discountAmount && requestDTO.getDiscountCode() != null) {
                        AmountAfterDiscount = Math.max(0, dtoAmount - discountAmount);
                        BigDecimal transactionFee = BigDecimal.valueOf(transactionFees).multiply(BigDecimal.valueOf(AmountAfterDiscount));
                        transactionFee = transactionFee.setScale(2, RoundingMode.HALF_UP);
                        newBalanceForTeacher = teacher.getBalance() + AmountAfterDiscount - transactionFee.doubleValue();
                        newBalanceForAdmin = Admin.getBalance() + transactionFee.doubleValue();
                        newBalanceForStudent = user.getBalance() - AmountAfterDiscount;
                        userRepository.updateBalanceAccountById(StudentId, newBalanceForStudent);
                    } else {
                        Double transactionFee = transactionFees * requestDTO.getAmount();
                        newBalanceForTeacher = teacher.getBalance() + requestDTO.getAmount() - transactionFee;
                        newBalanceForAdmin = Admin.getBalance() + transactionFee;
                        newBalanceForStudent = user.getBalance() - dtoAmount;
                        userRepository.updateBalanceAccountById(StudentId, newBalanceForStudent);
                    }
                }

                courseRepository.addStudentToCourseEnroll(requestDTO.getItem_register_id(), user.getId());
                userRepository.updateBalanceAccountById(TeacherId, newBalanceForTeacher);
                userRepository.updateBalanceAccountById(AdminId, newBalanceForAdmin);
                requestRepository.save(request);
                paymentRepository.save(paymentMethod);
                transactionRepository.save(transaction);
                courseDiscountRepository.deleteByCode(requestDTO.getDiscountCode());

                ObjContent objContent = new ObjContent();
                objContent.setStatus(true).setUser_id(user.getId()).setUser_name(user.getFull_name()).setEmail(user.getEmail()).setWorkshop_id(course.getId()).setWorkshop_name(course.getName());
                String urlCorCode = uploadQrCodeImage(objContent).toString();
                QrToken qrToken = new QrToken();
                qrToken.setCourse(course).setUser(user).setUrlQrCode(urlCorCode).setName(user.getFull_name()).setEmail(user.getEmail()).setStatus(true);
                qrCodeTickerRepository.save(qrToken);
                ResponseRequestOptions responseRequestOptions = new ResponseRequestOptions();
                responseRequestOptions
                        .setUrlQrCode(urlCorCode).setStatus("APPROVED")
                        .setUser_name(user.getFull_name()).setEmail(user.getEmail()).setUserId(user.getId())
                        .setWorkshopName(course.getName()).setWorkshopId(course.getId());
                return responseRequestOptions;
            }
        } catch (Exception e) {
            ResponseRequestOptions responseRequestOptions = new ResponseRequestOptions();
            responseRequestOptions.setStatus("PENDING");
            return responseRequestOptions;
        }
        return null;
    }

    private URL uploadQrCodeImage(ObjContent objContent) {
        try {
            BufferedImage qrCodeImage = qrCodeGenerator.generateQRCodeImage(objContent, 400, 400);
            String fileName = generateUniqueFileName();
            String storagePath = "qrcodes/" + fileName;

            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            ImageIO.write(qrCodeImage, "png", byteArrayOutputStream);
            byte[] qrCodeImageData = byteArrayOutputStream.toByteArray();

            Storage storage = StorageClient.getInstance(firebaseApp).bucket().getStorage();
            BlobInfo blobInfo = BlobInfo.newBuilder(firebaseApp.getOptions().getStorageBucket(), storagePath)
                    .setContentType("image/png")
                    .build();
            Blob blob = storage.create(blobInfo, qrCodeImageData);
            System.out.println("getMediaLink: " + blob.getMediaLink());
            long duration = 2221;
            TimeUnit unit = TimeUnit.HOURS;
            URL signedUrl = blob.signUrl(duration, unit);
            System.out.println("URL đã ký: " + signedUrl);
            return signedUrl;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    private String generateUniqueFileName() {

        long timestamp = System.currentTimeMillis();
        return "qr_code" + "_" + timestamp;
    }

}
