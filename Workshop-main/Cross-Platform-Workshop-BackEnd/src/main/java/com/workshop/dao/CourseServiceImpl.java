package com.workshop.dao;

import com.workshop.config.MapperGeneric;
import com.workshop.dto.CourseDTO.*;
import com.workshop.dto.mobile.CourseResponsesMobi;
import com.workshop.dto.mobile.QrResponsesMobi;
import com.workshop.dto.useDTO.UserInfoResponse;
import com.workshop.event.SendDiscountCodeEvent;
import com.workshop.model.*;
import com.workshop.model.courseModel.*;
import com.workshop.model.userModel.User;
import com.workshop.repositories.Course.*;
import com.workshop.repositories.*;
import com.workshop.repositories.User.UserRepository;
import com.workshop.service.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import java.util.*;
@Service
@Slf4j
@RequiredArgsConstructor
public class CourseServiceImpl implements CourseService {
    private final CourseRepository courseRepository;
    private final CourseDiscountRepository courseDiscountRepository;
    private final DiscountRepository discountRepository;
    private final CourseMediaInfoRepository courseMediaInfoRepository;
    private final UserService userService;
    private final UserRepository userRepository;
    private final CourseLocationRepository courseLocationRepository;
    private final CourseEnrollmentRepository courseEnrollmentRepository;
    private final LocationRepository locationRepository;
    private final ApplicationEventPublisher publisher;
    private final QrCodeTickerRepository qrCodeTickerRepository;
    boolean isCourse(Long Id) {
        Course course_exit = courseRepository.findCourseById(Id);
        return course_exit != null;
    }

    @Override
    public boolean addCourse(CourseRequest courseRequest) {
        User user = userService.getCurrentUserDetails();
        if (courseRequest != null) {
            //Add Course
            MapperGeneric<Course, CourseRequest> mapperGeneric = new MapperGeneric<>();
            MapperGeneric<CourseMediaInfo, CourseRequest.CourseMediaInfoDTOS> mapperMediaGeneric = new MapperGeneric<>();
            MapperGeneric<CourseLocation, CourseRequest.CourseLocation> mapperLocationGeneric = new MapperGeneric<>();
            List<CourseRequest.CourseMediaInfoDTOS> courseMediaInfoDTOSList = courseRequest.getMediaInfoList();
            List<CourseRequest.DiscountDTO> discountDTOSList = courseRequest.getDiscountDTOS();
            List<CourseRequest.CourseLocation> courseLocationsList = courseRequest.getCourseLocation();
            Course course = mapperGeneric.DTOmapToModel(courseRequest, Course.class);
            course.setTeacher(user);
            courseRepository.save(course);
            //Add Media into Course
            if (courseMediaInfoDTOSList != null) {
                for (CourseRequest.CourseMediaInfoDTOS mediaInfoDTOS : courseMediaInfoDTOSList) {
                    CourseMediaInfo mediaInfo = mapperMediaGeneric.DTOmapToModel(mediaInfoDTOS, CourseMediaInfo.class);
                    mediaInfo.setCourse(course);
                    courseMediaInfoRepository.save(mediaInfo);
                }
            }
            //Add Discount into Course
            if (discountDTOSList != null) {
                for (CourseRequest.DiscountDTO discountDTO : discountDTOSList) {
                    if (discountDTO.getQuantity() > 0) {
                        Discount discount = new Discount();
                        discount.setDescription(discountDTO.getDescription())
                                .setName(discountDTO.getName())
                                .setRemainingUses(discountDTO.getQuantity())
                                .setValueDiscount(discountDTO.getValueDiscount());
                        discountRepository.save(discount);
                        for (int i = 0; i < discountDTO.getQuantity(); i++) {
                            CourseDiscount courseDiscount = new CourseDiscount();
                            UUID randomUUID = UUID.randomUUID();
                            String randomDiscountCode = randomUUID.toString();
                            courseDiscount.setCode(randomDiscountCode).setRedemptionDate(discountDTO.getRedemptionDate()).setQuantity(discountDTO.getValueDiscount())
                                    .setDiscount(discount).setCourse(course).setStatus(CourseDiscount.Status.Available);
                            courseDiscountRepository.save(courseDiscount);
                        }
                    }
                }
            }
            //Add Location into Course
            if (courseLocationsList != null) {
                for (CourseRequest.CourseLocation courseLocation : courseLocationsList) {
                    CourseLocation location = mapperLocationGeneric.DTOmapToModel(courseLocation, CourseLocation.class);
                    location.setCourses(course);
                    courseLocationRepository.save(location);
                }
            }
            return true;
        } else {
            return false;
        }
    }
    @Override
    public boolean updateCourse(Long id, CourseUpdateRequest courseRequest) {
        User user = userService.getCurrentUserDetails();
        Course courseExit = courseRepository.findCourseById(id);
        try {
            MapperGeneric<Course, CourseUpdateRequest> mapperGeneric = new MapperGeneric<>();
            MapperGeneric<CourseMediaInfo, CourseUpdateRequest.CourseMediaInfoDTOS> mapperMediaGeneric = new MapperGeneric<>();
            MapperGeneric<CourseLocation, CourseUpdateRequest.CourseLocation> mapperLocationGeneric = new MapperGeneric<>();
            MapperGeneric<Discount, CourseUpdateRequest.DiscountDTO> mapperDiscountGeneric = new MapperGeneric<>();
            List<CourseUpdateRequest.CourseMediaInfoDTOS> courseMediaInfoDTOSList = courseRequest.getMediaInfoList();
            List<CourseUpdateRequest.DiscountDTO> discountDTOSList = courseRequest.getDiscountDTOS();
            List<CourseUpdateRequest.CourseLocation> courseLocationsList = courseRequest.getCourseLocation();
            Course course = mapperGeneric.DTOmapToModel(courseRequest, Course.class);
            course.setTeacher(user);
            courseRepository.updateCourse(id, course);
            if (courseMediaInfoDTOSList != null) {
                for (CourseUpdateRequest.CourseMediaInfoDTOS mediaInfoDTOS : courseMediaInfoDTOSList) {
                    CourseMediaInfo mediaInfo = mapperMediaGeneric.DTOmapToModel(mediaInfoDTOS, CourseMediaInfo.class);
                    Long cMda_id = mediaInfoDTOS.getId();
                    if (cMda_id > 0) {
                        courseMediaInfoRepository.updateCourse(cMda_id, mediaInfo);
                    } else {
                        mediaInfo.setCourse(courseExit);
                        courseMediaInfoRepository.save(mediaInfo);
                    }
                }
            }
            if (courseLocationsList != null) {
                for (CourseUpdateRequest.CourseLocation courseLocation : courseLocationsList) {
                    CourseLocation location = mapperLocationGeneric.DTOmapToModel(courseLocation, CourseLocation.class);
                    Long cLct_id = courseLocation.getId();
                    location.setCourses(courseExit);
                    if (cLct_id > 0) {
                        courseLocationRepository.updateCourseLocation(cLct_id, location);
                    } else {
                        location.setCourses(courseExit);
                        courseLocationRepository.save(location);
                    }
                }
            }
            return true;
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
            return false;
        }
    }
    @Override
    public boolean deleteCourse(Long id) {
        Course course = courseRepository.findCourseById(id);
        if (course.getName() != null) {
            courseRepository.delete(course);
            return true;
        } else {
            return false;
        }
    }
    @Override
    public boolean settingStatusCourse(Long id) {
        try {
            int result = courseRepository.chanceStatusCourseById(id);
            return result > 0;
        } catch (Exception exception) {
            throw new RuntimeException("Error: " + exception);
        }
    }
    @Override
    public List<UserInfoResponse> listStudentByCourse(Long id) {
        try {
            Course course = courseRepository.findCourseById(id);
            if (course != null) {
                List<UserInfoResponse> userInfoResponse = new ArrayList<>();
                List<User> users = courseRepository.listUserInCourse(id);
                MapperGeneric<User, UserInfoResponse> mapper = new MapperGeneric<>();
                for (User user : users) {
                    UserInfoResponse userResponse = mapper.ModelmapToDTO(user, UserInfoResponse.class);
                    userInfoResponse.add(userResponse);
                }
                return userInfoResponse;
            } else {
                return null;
            }
        } catch (RuntimeException runtimeException) {
            System.out.println("Error: " + runtimeException.getMessage());
            return null;
        }
    }
    @Override
    public List<CourseResponses> listCourseTeacher() {
        try {
            User teacher = userService.getCurrentUserDetails();
            User use = userService.getCurrentUserDetails();
            List<Course> coursesEntityList = courseRepository.listCoursebyTeacherId(teacher.getId());
            List<CourseResponses> coursesResponesList = new ArrayList<>();

            MapperGeneric<Location, CourseResponses.CourseLocation.locationResponse> locationMapper = new MapperGeneric<>();
            MapperGeneric<Course, CourseResponses> CourseMapper = new MapperGeneric<>();
            MapperGeneric<CourseMediaInfo, CourseResponses.CourseMediaInfo> CourseMediaMapper = new MapperGeneric<>();
            MapperGeneric<CourseLocation, CourseResponses.CourseLocation> CourseLocationMapper = new MapperGeneric<>();
            MapperGeneric<Discount, CourseResponses.DiscountDTO> DiscountDToMapper = new MapperGeneric<>();
            for (Course course : coursesEntityList) {
                List<CourseResponses.StudentEnrollment> studentEnrollments = new ArrayList<>();
                List<CourseResponses.CourseMediaInfo> courseInfoMediaList = new ArrayList<>();
                List<CourseResponses.CourseLocation> courseLocationsList = new ArrayList<>();
                List<CourseResponses.DiscountDTO> DiscountDTOList = new ArrayList<>();
                CourseResponses courseResponse = CourseMapper.ModelmapToDTO(course, CourseResponses.class);
                courseResponse.setId(course.getId());
                courseResponse.setTeacher(use.getFull_name());
                for (CourseEnrollment enrollment : course.getEnrolledStudents()) {
                    CourseResponses.StudentEnrollment studentEnrollment = new CourseResponses.StudentEnrollment();
                    studentEnrollment.setId(enrollment.getEnrolledStudent().getId());
                    studentEnrollment.setName(enrollment.getEnrolledStudent().getUser_name());
                    studentEnrollments.add(studentEnrollment);
                }
                List<CourseResponses.DiscountDTO> tempDiscountList = new ArrayList<>();
                for (CourseDiscount courseDiscount : course.getCourseDiscounts()) {
                    Discount discount = courseDiscount.getDiscount();
                    CourseResponses.DiscountDTO discountDTO = DiscountDToMapper.ModelmapToDTO(discount, CourseResponses.DiscountDTO.class);
                    discountDTO.setQuantity(courseDiscount.getQuantity());
                    discountDTO.setRedemptionDate(courseDiscount.getRedemptionDate());
                    discountDTO.setId(discount.getId());
                    boolean isAlreadyExists = false;
                    for (CourseResponses.DiscountDTO existingDiscountDTO : tempDiscountList) {
                        if (Objects.equals(existingDiscountDTO.getId(), discountDTO.getId())) {
                            isAlreadyExists = true;
                            break;
                        }
                    }
                    if (!isAlreadyExists) {
                        DiscountDTOList.add(discountDTO);
                        tempDiscountList.add(discountDTO);
                    }
                }
                for (CourseMediaInfo courseMediaInfo : course.getCourseOnlineInfos()) {
                    if (courseMediaInfo.getCourse().equals(course)) {
                        CourseResponses.CourseMediaInfo courseInfoMedia = CourseMediaMapper.ModelmapToDTO(courseMediaInfo, CourseResponses.CourseMediaInfo.class);
                        courseInfoMedia.setId(courseMediaInfo.getId());
                        courseInfoMediaList.add(courseInfoMedia);
                    }
                }
                for (CourseLocation courseLocation : course.getCourseLocation()) {
                    CourseResponses.CourseLocation courseLocal = CourseLocationMapper.ModelmapToDTO(courseLocation, CourseResponses.CourseLocation.class);
                    courseLocal.setId(courseLocation.getId());
                    if (courseLocation.getLocations() != null) {
                        CourseResponses.CourseLocation.locationResponse location =
                                locationMapper.ModelmapToDTO(courseLocation.getLocations(), CourseResponses.CourseLocation.locationResponse.class);
                        courseLocal.setLocationResponse(location);
                    }
                    courseLocationsList.add(courseLocal);
                }
                courseResponse.setStudentEnrollments(studentEnrollments);
                courseResponse.setCourseMediaInfos(courseInfoMediaList);
                courseResponse.setDiscountDTOS(DiscountDTOList);
                courseResponse.setCourseLocations(courseLocationsList);
                coursesResponesList.add(courseResponse);
            }
            return coursesResponesList;
        } catch (RuntimeException runtimeException) {
            throw new RuntimeException(runtimeException);
        }
    }
    @Override
    public boolean addDiscountToStudent(Long Course_id, List<Long> studentIds) {
        try {
            Course course_exit = courseRepository.findCourseById(Course_id);
            if (course_exit != null && course_exit.isPublic()) {
                long course_id = course_exit.getId();
                List<CourseDiscount> courseDiscountsList = courseDiscountRepository.findDiscountsByCourseIdAndStatus(course_id, CourseDiscount.Status.Available);
                List<CourseDiscount> selectedDiscounts = new ArrayList<>();
                Random random = new Random();
                for (Long id : studentIds) {
                    Optional<User> user = userRepository.findById(id);
                    if (user.isPresent()) {
                        User userExit = user.get();
                        if (!courseDiscountsList.isEmpty()) {
                            int randomIndex = random.nextInt(courseDiscountsList.size());
                            CourseDiscount selectedDiscount = courseDiscountsList.remove(randomIndex);
                            publisher.publishEvent(new SendDiscountCodeEvent(
                                    userExit.getUser_name(),
                                    userExit.getEmail(),
                                    course_exit.getName(),
                                    selectedDiscount.getCode(),
                                    selectedDiscount.getDiscount().getValueDiscount()));
                            Long exitId = selectedDiscount.getId();
                            courseDiscountRepository.updateCourseDiscountStatus(exitId, CourseDiscount.Status.Email_Sent);
                            selectedDiscounts.add(selectedDiscount);
                        }
                    }
                }
                return true;
            } else {
                return false;
            }

        } catch (RuntimeException runtimeException) {
            System.out.println("Error: " + runtimeException.getMessage());
            return false;
        }
    }
    @Override
    public List<CourseResponses> listWorkshopEnable() {
        List<Course> coursesEntityList = courseRepository.listCoursePublic();
        List<CourseResponses> coursesResponesList = new ArrayList<>();
        MapperGeneric<Location, CourseResponses.CourseLocation.locationResponse> locationMapper = new MapperGeneric<>();
        MapperGeneric<Course, CourseResponses> CourseMapper = new MapperGeneric<>();
        MapperGeneric<CourseMediaInfo, CourseResponses.CourseMediaInfo> CourseMediaMapper = new MapperGeneric<>();
        MapperGeneric<CourseLocation, CourseResponses.CourseLocation> CourseLocationMapper = new MapperGeneric<>();
        MapperGeneric<Discount, CourseResponses.DiscountDTO> DiscountDToMapper = new MapperGeneric<>();
        for (Course course : coursesEntityList) {
            List<CourseResponses.StudentEnrollment> studentEnrollments = new ArrayList<>();
            List<CourseResponses.CourseMediaInfo> courseInfoMediaList = new ArrayList<>();
            List<CourseResponses.CourseLocation> courseLocationsList = new ArrayList<>();
            List<CourseResponses.DiscountDTO> DiscountDTOList = new ArrayList<>();
            CourseResponses courseResponse = CourseMapper.ModelmapToDTO(course, CourseResponses.class);
            courseResponse.setId(course.getId());
            courseResponse.setTeacher_id(course.getTeacher().getId());
            courseResponse.setTeacher(course.getTeacher().getFull_name());
            courseResponse.setTeacher_img(course.getTeacher().getImage_url());
            for (CourseEnrollment enrollment : course.getEnrolledStudents()) {
                CourseResponses.StudentEnrollment studentEnrollment = new CourseResponses.StudentEnrollment();
                studentEnrollment.setId(enrollment.getEnrolledStudent().getId());
                studentEnrollment.setName(enrollment.getEnrolledStudent().getUser_name());
                studentEnrollments.add(studentEnrollment);
            }
            List<CourseResponses.DiscountDTO> tempDiscountList = new ArrayList<>();
            for (CourseDiscount courseDiscount : course.getCourseDiscounts()) {
                Discount discount = courseDiscount.getDiscount();
                CourseResponses.DiscountDTO discountDTO = DiscountDToMapper.ModelmapToDTO(discount, CourseResponses.DiscountDTO.class);
                discountDTO.setQuantity(courseDiscount.getQuantity());
                discountDTO.setRedemptionDate(courseDiscount.getRedemptionDate());
                discountDTO.setId(discount.getId());
                boolean isAlreadyExists = false;
                for (CourseResponses.DiscountDTO existingDiscountDTO : tempDiscountList) {
                    if (Objects.equals(existingDiscountDTO.getId(), discountDTO.getId())) {
                        isAlreadyExists = true;
                        break;
                    }
                }
                if (!isAlreadyExists) {
                    DiscountDTOList.add(discountDTO);
                    tempDiscountList.add(discountDTO);
                }
            }
            for (CourseMediaInfo courseMediaInfo : course.getCourseOnlineInfos()) {
                if (courseMediaInfo.getCourse().equals(course)) {
                    CourseResponses.CourseMediaInfo courseInfoMedia = CourseMediaMapper.ModelmapToDTO(courseMediaInfo, CourseResponses.CourseMediaInfo.class);
                    courseInfoMedia.setId(courseMediaInfo.getId());
                    courseInfoMediaList.add(courseInfoMedia);
                }
            }
            for (CourseLocation courseLocation : course.getCourseLocation()) {
                CourseResponses.CourseLocation courseLocal = CourseLocationMapper.ModelmapToDTO(courseLocation, CourseResponses.CourseLocation.class);
                courseLocal.setId(courseLocation.getId());
                if (courseLocation.getLocations() != null) {
                    CourseResponses.CourseLocation.locationResponse location =
                            locationMapper.ModelmapToDTO(courseLocation.getLocations(), CourseResponses.CourseLocation.locationResponse.class);
                    courseLocal.setLocationResponse(location);
                }
                courseLocationsList.add(courseLocal);
            }
            courseResponse.setStudentEnrollments(studentEnrollments);
            courseResponse.setCourseMediaInfos(courseInfoMediaList);
            courseResponse.setDiscountDTOS(DiscountDTOList);
            courseResponse.setCourseLocations(courseLocationsList);
            coursesResponesList.add(courseResponse);
        }
        return coursesResponesList;
    }
    @Override
    public List<CourseResponses> listWorkshopStudent() {
        User user = userService.getCurrentUserDetails();
        List<CourseResponses> coursesResponesList = new ArrayList<>();
        if(user!=null){
            List<Course> coursesEntityList = courseEnrollmentRepository.findWorkshopByStudent(user);
            MapperGeneric<Location, CourseResponses.CourseLocation.locationResponse> locationMapper = new MapperGeneric<>();
            MapperGeneric<Course, CourseResponses> CourseMapper = new MapperGeneric<>();
            MapperGeneric<CourseMediaInfo, CourseResponses.CourseMediaInfo> CourseMediaMapper = new MapperGeneric<>();
            MapperGeneric<CourseLocation, CourseResponses.CourseLocation> CourseLocationMapper = new MapperGeneric<>();
            MapperGeneric<Discount, CourseResponses.DiscountDTO> DiscountDToMapper = new MapperGeneric<>();
            for (Course course : coursesEntityList) {
                List<CourseResponses.StudentEnrollment> studentEnrollments = new ArrayList<>();
                List<CourseResponses.CourseMediaInfo> courseInfoMediaList = new ArrayList<>();
                List<CourseResponses.CourseLocation> courseLocationsList = new ArrayList<>();
                List<CourseResponses.DiscountDTO> DiscountDTOList = new ArrayList<>();
                CourseResponses courseResponse = CourseMapper.ModelmapToDTO(course, CourseResponses.class);
                courseResponse.setId(course.getId());
                courseResponse.setTeacher(course.getTeacher().getFull_name());
                for (CourseEnrollment enrollment : course.getEnrolledStudents()) {
                    CourseResponses.StudentEnrollment studentEnrollment = new CourseResponses.StudentEnrollment();
                    studentEnrollment.setId(enrollment.getEnrolledStudent().getId());
                    studentEnrollment.setName(enrollment.getEnrolledStudent().getUser_name());
                    studentEnrollments.add(studentEnrollment);
                }
                List<CourseResponses.DiscountDTO> tempDiscountList = new ArrayList<>();
                for (CourseDiscount courseDiscount : course.getCourseDiscounts()) {
                    Discount discount = courseDiscount.getDiscount();
                    CourseResponses.DiscountDTO discountDTO = DiscountDToMapper.ModelmapToDTO(discount, CourseResponses.DiscountDTO.class);
                    discountDTO.setQuantity(courseDiscount.getQuantity());
                    discountDTO.setRedemptionDate(courseDiscount.getRedemptionDate());
                    discountDTO.setId(discount.getId());
                    boolean isAlreadyExists = false;
                    for (CourseResponses.DiscountDTO existingDiscountDTO : tempDiscountList) {
                        if (Objects.equals(existingDiscountDTO.getId(), discountDTO.getId())) {
                            isAlreadyExists = true;
                            break;
                        }
                    }
                    if (!isAlreadyExists) {
                        DiscountDTOList.add(discountDTO);
                        tempDiscountList.add(discountDTO);
                    }
                }
                for (CourseMediaInfo courseMediaInfo : course.getCourseOnlineInfos()) {
                    if (courseMediaInfo.getCourse().equals(course)) {
                        CourseResponses.CourseMediaInfo courseInfoMedia = CourseMediaMapper.ModelmapToDTO(courseMediaInfo, CourseResponses.CourseMediaInfo.class);
                        courseInfoMedia.setId(courseMediaInfo.getId());
                        courseInfoMediaList.add(courseInfoMedia);
                    }
                }
                for (CourseLocation courseLocation : course.getCourseLocation()) {
                    CourseResponses.CourseLocation courseLocal = CourseLocationMapper.ModelmapToDTO(courseLocation, CourseResponses.CourseLocation.class);
                    courseLocal.setId(courseLocation.getId());
                    if (courseLocation.getLocations() != null) {
                        CourseResponses.CourseLocation.locationResponse location =
                                locationMapper.ModelmapToDTO(courseLocation.getLocations(), CourseResponses.CourseLocation.locationResponse.class);
                        courseLocal.setLocationResponse(location);
                    }
                    courseLocationsList.add(courseLocal);
                }
                courseResponse.setStudentEnrollments(studentEnrollments);
                courseResponse.setCourseMediaInfos(courseInfoMediaList);
                courseResponse.setDiscountDTOS(DiscountDTOList);
                courseResponse.setCourseLocations(courseLocationsList);
                coursesResponesList.add(courseResponse);
            }
            return coursesResponesList;
        }
        else {
            return coursesResponesList;
        }

    }
    @Override
    public int checkCodeDiscount(Long CourseId,String discountCode) {
        try{
            if(discountCode!=null){
                int value = 0;
                CourseDiscount courseDiscountValue = courseDiscountRepository.findByCode(discountCode);
                if(courseDiscountValue ==null){return - 1;}
                CourseDiscount courseDiscount = courseDiscountRepository.findDiscountsByCourseIdAndCode(CourseId,discountCode);
                if (courseDiscount != null && courseDiscount.getStatus().equals(CourseDiscount.Status.Available)) {
                    value = courseDiscount.getQuantity();
                    return value;
                }else{return 0;}
            }else{return 0;}
        }catch (Exception e){return 0;}
    }
    @Override
    public CourseResponses courseById(Long id) {
        try {
            boolean result = isCourse(id);
            Course course = courseRepository.CoursePublic(id);
            if (result && course!=null){
                MapperGeneric<Location, CourseResponses.CourseLocation.locationResponse> locationMapper = new MapperGeneric<>();
                MapperGeneric<Course, CourseResponses> CourseMapper = new MapperGeneric<>();
                MapperGeneric<CourseMediaInfo, CourseResponses.CourseMediaInfo> CourseMediaMapper = new MapperGeneric<>();
                MapperGeneric<CourseLocation, CourseResponses.CourseLocation>CourseLocationMapper = new MapperGeneric<>();
                MapperGeneric<Discount, CourseResponses.DiscountDTO> DiscountDToMapper = new MapperGeneric<>();
                List<CourseResponses.StudentEnrollment> studentEnrollments = new ArrayList<>();
                List<CourseResponses.CourseMediaInfo> courseInfoMediaList = new ArrayList<>();
                List<CourseResponses.CourseLocation> courseLocationsList = new ArrayList<>();
                List<CourseResponses.DiscountDTO> DiscountDTOList = new ArrayList<>();
                CourseResponses courseResponse = CourseMapper.ModelmapToDTO(course, CourseResponses.class);
                courseResponse.setId(course.getId());
                courseResponse.setTeacher(course.getTeacher().getFull_name());
                for (CourseEnrollment enrollment : course.getEnrolledStudents()){
                    CourseResponses.StudentEnrollment studentEnrollment = new CourseResponses.StudentEnrollment();
                    studentEnrollment.setId(enrollment.getEnrolledStudent().getId());
                    studentEnrollment.setName(enrollment.getEnrolledStudent().getUser_name());
                    studentEnrollments.add(studentEnrollment);
                }
                List<CourseResponses.DiscountDTO> tempDiscountList = new ArrayList<>();
                for(CourseDiscount courseDiscount : course.getCourseDiscounts()){
                    Discount discount = courseDiscount.getDiscount();
                    CourseResponses.DiscountDTO discountDTO = DiscountDToMapper.ModelmapToDTO(discount, CourseResponses.DiscountDTO.class);
                    discountDTO.setQuantity(courseDiscount.getQuantity());
                    discountDTO.setRedemptionDate(courseDiscount.getRedemptionDate());
                    discountDTO.setId(discount.getId());
                    boolean isAlreadyExists = false;
                    for (CourseResponses.DiscountDTO existingDiscountDTO : tempDiscountList) {
                        if (Objects.equals(existingDiscountDTO.getId(), discountDTO.getId())) {
                            isAlreadyExists = true;
                            break;}}
                    if (!isAlreadyExists) {
                        DiscountDTOList.add(discountDTO);
                        tempDiscountList.add(discountDTO);
                    }
                }
                for (CourseMediaInfo courseMediaInfo : course.getCourseOnlineInfos()){
                    if(courseMediaInfo.getCourse().equals(course)){
                        CourseResponses.CourseMediaInfo courseInfoMedia = CourseMediaMapper.ModelmapToDTO(courseMediaInfo, CourseResponses.CourseMediaInfo.class);
                        courseInfoMedia.setId(courseMediaInfo.getId());
                        courseInfoMediaList.add(courseInfoMedia);
                    }
                }
                for (CourseLocation courseLocation : course.getCourseLocation()){
                    CourseResponses.CourseLocation courseLocal = CourseLocationMapper.ModelmapToDTO(courseLocation, CourseResponses.CourseLocation.class);
                    courseLocal.setId(courseLocation.getId());
                    if(courseLocation.getLocations()!=null){
                        CourseResponses.CourseLocation.locationResponse location =
                                locationMapper.ModelmapToDTO(courseLocation.getLocations(), CourseResponses.CourseLocation.locationResponse.class);
                        courseLocal.setLocationResponse(location);
                    }courseLocationsList.add(courseLocal);
                }
                courseResponse.setStudentEnrollments(studentEnrollments);
                courseResponse.setCourseMediaInfos(courseInfoMediaList);
                courseResponse.setDiscountDTOS(DiscountDTOList);
                courseResponse.setCourseLocations(courseLocationsList);
               return courseResponse ;
            } else {
                return null;
            }
        } catch (RuntimeException runtimeException) {
            System.out.println("Error: " + runtimeException.getMessage());
            return null;
        }
    }
    @Override
    public boolean checkUserInCourse(String email, Long course_id) {
       try{
           boolean result = isCourse(course_id);
           User user = userRepository.getUserEditByMail(email);
           Long user_id = user.getId();
           if(result){
               return courseEnrollmentRepository.checkUserInCourse(user_id,course_id);
           }
           return false;
       }catch (Exception e){return false;}
    }
    @Override
    public boolean UpdateLocationToLocationCourse(Long CourseLocation_id, Long Location_Id) {
        try{
            CourseLocation courseLocation = courseLocationRepository.findCourseLocationById(CourseLocation_id);
            Location location = locationRepository.findLocationById(Location_Id);
            if(courseLocation!=null && location!=null){
                courseLocationRepository.updateLocationToLocationCourse(CourseLocation_id,Location_Id);
                return true;
            }else{
                return false;
            }
        }catch (Exception exception){
            throw  exception;
        }
    }

    @Override
    public QrResponsesMobi checkQrTicker(Long userId, Long workshopId) {
        QrResponsesMobi qrResponsesMobi = new QrResponsesMobi();
        QrToken qrToken = qrCodeTickerRepository.findQrToken(userId,workshopId);
        if(qrToken!=null){
            if(qrToken.isStatus()){
                qrResponsesMobi.setStatus("valid").setMessage("ticket is validation");
            }else{
                qrResponsesMobi.setStatus("outdated").setMessage("ticket is outdated");
            }
        }else{
            qrResponsesMobi.setStatus("fail").setMessage("ticket is not validation");
        }
        return qrResponsesMobi;
    }

    public List<CourseResponses> listCourseTeacherById(Long courseId) {
        try {
            Course courseEntity = courseRepository.findCourseById(courseId);
            if (courseEntity != null) {
                User teacher = userService.getCurrentUserDetails();
                User use = userService.getCurrentUserDetails();
                List<Course> coursesEntityList = courseRepository.listCoursebyTeacherId(teacher.getId());
                List<CourseResponses> coursesResponesList = new ArrayList<>();
                MapperGeneric<Location, CourseResponses.CourseLocation.locationResponse> locationMapper = new MapperGeneric<>();
                MapperGeneric<Course, CourseResponses> CourseMapper = new MapperGeneric<>();
                MapperGeneric<CourseMediaInfo, CourseResponses.CourseMediaInfo> CourseMediaMapper = new MapperGeneric<>();
                MapperGeneric<CourseLocation, CourseResponses.CourseLocation> CourseLocationMapper = new MapperGeneric<>();
                MapperGeneric<Discount, CourseResponses.DiscountDTO> DiscountDToMapper = new MapperGeneric<>();
                for (Course course : coursesEntityList) {
                    if (course.getId().equals(courseId)) {
                        List<CourseResponses.StudentEnrollment> studentEnrollments = new ArrayList<>();
                        List<CourseResponses.CourseMediaInfo> courseInfoMediaList = new ArrayList<>();
                        List<CourseResponses.CourseLocation> courseLocationsList = new ArrayList<>();
                        List<CourseResponses.DiscountDTO> DiscountDTOList = new ArrayList<>();

                        CourseResponses courseResponse = CourseMapper.ModelmapToDTO(course, CourseResponses.class);
                        courseResponse.setId(course.getId());
                        courseResponse.setTeacher(use.getFull_name());
                        for (CourseEnrollment enrollment : course.getEnrolledStudents()) {
                            CourseResponses.StudentEnrollment studentEnrollment = new CourseResponses.StudentEnrollment();
                            studentEnrollment.setId(enrollment.getEnrolledStudent().getId());
                            studentEnrollment.setName(enrollment.getEnrolledStudent().getUser_name());
                            studentEnrollments.add(studentEnrollment);
                        }
                        List<CourseResponses.DiscountDTO> tempDiscountList = new ArrayList<>();
                        for (CourseDiscount courseDiscount : course.getCourseDiscounts()) {
                            Discount discount = courseDiscount.getDiscount();
                            CourseResponses.DiscountDTO discountDTO = DiscountDToMapper.ModelmapToDTO(discount, CourseResponses.DiscountDTO.class);
                            discountDTO.setQuantity(courseDiscount.getQuantity());
                            discountDTO.setRedemptionDate(courseDiscount.getRedemptionDate());
                            discountDTO.setId(discount.getId());
                            boolean isAlreadyExists = false;
                            for (CourseResponses.DiscountDTO existingDiscountDTO : tempDiscountList) {
                                if (Objects.equals(existingDiscountDTO.getId(), discountDTO.getId())) {
                                    isAlreadyExists = true;
                                    break;
                                }
                            }
                            if (!isAlreadyExists) {
                                DiscountDTOList.add(discountDTO);
                                tempDiscountList.add(discountDTO);
                            }
                        }
                        for (CourseMediaInfo courseMediaInfo : course.getCourseOnlineInfos()) {
                            if (courseMediaInfo.getCourse().equals(course)) {
                                CourseResponses.CourseMediaInfo courseInfoMedia = CourseMediaMapper.ModelmapToDTO(courseMediaInfo, CourseResponses.CourseMediaInfo.class);
                                courseInfoMedia.setId(courseMediaInfo.getId());
                                courseInfoMediaList.add(courseInfoMedia);
                            }
                        }
                        for (CourseLocation courseLocation : course.getCourseLocation()) {
                            CourseResponses.CourseLocation courseLocal = CourseLocationMapper.ModelmapToDTO(courseLocation, CourseResponses.CourseLocation.class);
                            courseLocal.setId(courseLocation.getId());
                            if (courseLocation.getLocations() != null) {
                                CourseResponses.CourseLocation.locationResponse location =
                                        locationMapper.ModelmapToDTO(courseLocation.getLocations(), CourseResponses.CourseLocation.locationResponse.class);
                                courseLocal.setLocationResponse(location);
                            }
                            courseLocationsList.add(courseLocal);
                        }
                        courseResponse.setStudentEnrollments(studentEnrollments);
                        courseResponse.setCourseMediaInfos(courseInfoMediaList);
                        courseResponse.setDiscountDTOS(DiscountDTOList);
                        courseResponse.setCourseLocations(courseLocationsList);
                        coursesResponesList.add(courseResponse);
                    }
                }
                return coursesResponesList;
            } else {
                return Collections.emptyList();
            }
        } catch (RuntimeException runtimeException) {
            throw new RuntimeException(runtimeException);
        }
    }
    @Override
    public List<CourseResponsesMobi> listCourseStudentById()
    {
        User user = userService.getCurrentUserDetails();
       if(user!=null){
           List<CourseResponsesMobi> courseResponsesMobiList = new ArrayList<>();
           List<Course> coursesEntityList = courseEnrollmentRepository.findEnrolledCoursesByStudent(user);
           if((long) coursesEntityList.size() >0){
               for (Course course : coursesEntityList){
                   long id = course.getId();
                   QrToken qrToken = qrCodeTickerRepository.findQrTokensByUserAndCourse(user,id);
                   CourseResponsesMobi courseResponsesMobi = new CourseResponsesMobi();
                   List<CourseResponsesMobi.CourseLocationMobi> courseLocationMobi =  new ArrayList<>();
                   for(CourseLocation courseLocation : course.getCourseLocation()){
                       CourseResponsesMobi.CourseLocationMobi locationMobi= new CourseResponsesMobi.CourseLocationMobi();
                       locationMobi.setName(courseLocation.getLocations().getName())
                       .setId(courseLocation.getId()).setArea(courseLocation.getArea())
                        .setDescription(courseLocation.getLocations().getDescription())
                         .setAddress(courseLocation.getLocations().getAddress())
                               .setSchedule_Date(courseLocation.getSchedule_Date()).setStatusAvailable(courseLocation.getLocations().getStatusAvailable());
                       courseLocationMobi.add(locationMobi);
                   }
                   long getEnrollmentCountByCourse = courseEnrollmentRepository.countEnrollmentsByCourse(course);
                   courseResponsesMobi.setId(course.getId())
                           .setDescription(course.getDescription()).setName(course.getName())
                           .setStartDate(course.getStartDate()).setEndDate(course.getEndDate()).setCourseLocations(courseLocationMobi)
                           .setPrice(course.getPrice()).setStudent_count(course.getStudent_count()).setStudent_endroll((int) getEnrollmentCountByCourse)
                           .setTeacher(course.getTeacher().getFull_name()).setUrlQrCode(qrToken.getUrlQrCode());
                   courseResponsesMobiList.add(courseResponsesMobi);
               }
               return courseResponsesMobiList;
           }else{
               return courseResponsesMobiList;
           }
       }else{
           return null;
       }
    }
}
