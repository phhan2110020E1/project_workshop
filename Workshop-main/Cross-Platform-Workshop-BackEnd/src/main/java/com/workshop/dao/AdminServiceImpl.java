package com.workshop.dao;

import com.workshop.config.MapperGeneric;
import com.workshop.dto.CourseDTO.CourseResponses;
import com.workshop.dto.useDTO.UserInfoResponse;
import com.workshop.model.Discount;
import com.workshop.model.Location;
import com.workshop.model.courseModel.*;
import com.workshop.model.userModel.Roles;
import com.workshop.model.userModel.User;
import com.workshop.model.userModel.UserAddresses;
import com.workshop.model.userModel.UserBanking;
import com.workshop.repositories.Course.CourseRepository;
import com.workshop.repositories.User.UserAddressRepository;
import com.workshop.repositories.User.UserRepository;
import com.workshop.service.AdminService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Slf4j
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {
    private final UserRepository userRepository;
    private  final UserAddressRepository userAddressRepository;
    private final CourseRepository courseRepository;

    @Override
    public boolean chanceIsEnableWithRoleAndId(Long Id) {
        try {
            int result = userRepository.chanceStatusAccountById(Id);
            return result > 0;
        }
        catch (Exception exception) {
            throw new RuntimeException("Error: " + exception);
        }
    }
    @Override
    public boolean deleteAddressOfUser(Long userId, Long userAddressId){
        try {
           Optional<User> user = userRepository.findById(userId);
           if(user.isPresent()){
               User user1 = user.get();
               userAddressRepository.deleteUserAddressesByUserAndId(user1,userAddressId);
               return true;
           }else{
               return false;
           }
        } catch (Exception exception) {
            throw new RuntimeException("Error: " + exception);
        }
    }
    @Override
    public UserInfoResponse findUserById(Long userId) {
        MapperGeneric<UserAddresses, UserInfoResponse.UserAddress> UserAddressMapper = new MapperGeneric<>();
        MapperGeneric<User, UserInfoResponse> UserMapper = new MapperGeneric<>();
        MapperGeneric<UserBanking, UserInfoResponse.UserBank> UserBankMapper = new MapperGeneric<>();
        Optional<User> userOption = userRepository.findById(userId);
        if(userOption.isPresent()){
            User userFull = userOption.get();
            List<UserInfoResponse.UserAddress> userAddressesList = new ArrayList<>();

            List<String>list = new ArrayList<>();
            for (Roles roles : userFull.getRoles()){
                list.add(roles.getName());
            }
            for(UserAddresses addresses : userFull.getUserAddresses())
            {
                UserInfoResponse.UserAddress userAddress = UserAddressMapper.ModelmapToDTO(addresses,UserInfoResponse.UserAddress.class);
                userAddress.setId(addresses.getId());
                userAddressesList.add(userAddress);
            }
            List<UserInfoResponse.UserBank> userBankList = new ArrayList<>();
            for(UserBanking userBanking : userFull.getUserBanks()){
                UserInfoResponse.UserBank userBank = UserBankMapper.ModelmapToDTO(userBanking,UserInfoResponse.UserBank.class);
                userBank.setId(userBanking.getId());
                userBankList.add(userBank);
            }
            UserInfoResponse userInfoResponse = UserMapper.ModelmapToDTO(userFull,UserInfoResponse.class);
            userInfoResponse.setRoles(list);
            userInfoResponse.setUserBanks(userBankList);
            userInfoResponse.setUserAddresses(userAddressesList);
            return userInfoResponse;
        }else{
            return new UserInfoResponse();
        }
    }

    @Override
    public List<UserInfoResponse> listAccountByRole(String role) {
        List<UserInfoResponse> listUserInfoResponse = new ArrayList<>();
        List<User> ListUser = userRepository.findUsersByRoleName(role);
        for(User user : ListUser){
            MapperGeneric<User,UserInfoResponse> userMapper = new MapperGeneric<>();
            MapperGeneric<UserBanking, UserInfoResponse.UserBank> UserBankMapper = new MapperGeneric<>();
            UserInfoResponse userInfoResponse =  userMapper.ModelmapToDTO(user,UserInfoResponse.class);
            List<UserInfoResponse.UserAddress> listUserAddressResponse = new ArrayList<>();
            for(UserAddresses userAddresses : user.getUserAddresses()){
                MapperGeneric<UserAddresses,UserInfoResponse.UserAddress> userAddressMapper = new MapperGeneric<>();
                UserInfoResponse.UserAddress userAddress = userAddressMapper.ModelmapToDTO(userAddresses,UserInfoResponse.UserAddress.class);
                listUserAddressResponse.add(userAddress);
            }
            List<UserInfoResponse.UserBank> userBankList = new ArrayList<>();
            for(UserBanking userBanking : user.getUserBanks()){
                UserInfoResponse.UserBank userBank = UserBankMapper.ModelmapToDTO(userBanking,UserInfoResponse.UserBank.class);
                userBank.setId(userBanking.getId());
                userBankList.add(userBank);
            }
            List<String>roleList =new ArrayList<>();
            for(Roles roles : user.getRoles()){
                roleList.add(roles.getName());
            }
            userInfoResponse.setUserBanks(userBankList);
            userInfoResponse.setRoles(roleList);
            userInfoResponse.setUserAddresses(listUserAddressResponse);
            listUserInfoResponse.add(userInfoResponse);
        }
        return listUserInfoResponse;
    }

    @Override
    public List<UserInfoResponse> listAccount() {
        List<UserInfoResponse> listUserInfoResponse = new ArrayList<>();
        List<User> ListUser = userRepository.findUsersNonAdmin();
        for(User user : ListUser){
            MapperGeneric<User,UserInfoResponse> userMapper = new MapperGeneric<>();
            MapperGeneric<UserBanking, UserInfoResponse.UserBank> UserBankMapper = new MapperGeneric<>();
            UserInfoResponse userInfoResponse =  userMapper.ModelmapToDTO(user,UserInfoResponse.class);
            List<UserInfoResponse.UserAddress> listUserAddressResponse = new ArrayList<>();
            List<UserInfoResponse.UserBank> userBankList = new ArrayList<>();
            for(UserBanking userBanking : user.getUserBanks()){
                UserInfoResponse.UserBank userBank = UserBankMapper.ModelmapToDTO(userBanking,UserInfoResponse.UserBank.class);
                userBank.setId(userBanking.getId());
                userBankList.add(userBank);
            }
            for(UserAddresses userAddresses : user.getUserAddresses()){
                MapperGeneric<UserAddresses,UserInfoResponse.UserAddress> userAddressMapper = new MapperGeneric<>();
                UserInfoResponse.UserAddress userAddress = userAddressMapper.ModelmapToDTO(userAddresses,UserInfoResponse.UserAddress.class);
                userAddress.setId(userAddresses.getId());
                listUserAddressResponse.add(userAddress);
            }
            List<String>roleList =new ArrayList<>();
            for(Roles role : user.getRoles()){
                roleList.add(role.getName());
            }
            userInfoResponse.setUserBanks(userBankList);
            userInfoResponse.setId(user.getId());
            userInfoResponse.setRoles(roleList);
            userInfoResponse.setUserAddresses(listUserAddressResponse);
            listUserInfoResponse.add(userInfoResponse);
        }
        return listUserInfoResponse;
    }

    @Override
    public List<CourseResponses> listCourse() {
        List<Course> coursesEntityList = courseRepository.findAll();
        List<CourseResponses> coursesResponesList = new ArrayList<>();
        MapperGeneric<Location, CourseResponses.CourseLocation.locationResponse> locationMapper = new MapperGeneric<>();
        MapperGeneric<Course, CourseResponses> CourseMapper = new MapperGeneric<>();
        MapperGeneric<CourseMediaInfo, CourseResponses.CourseMediaInfo> CourseMediaMapper = new MapperGeneric<>();
        MapperGeneric<CourseLocation, CourseResponses.CourseLocation>CourseLocationMapper = new MapperGeneric<>();
        MapperGeneric<Discount, CourseResponses.DiscountDTO> DiscountDToMapper = new MapperGeneric<>();

        for (Course course : coursesEntityList)
        {
            List<CourseResponses.StudentEnrollment> studentEnrollments = new ArrayList<>();
            List<CourseResponses.CourseMediaInfo> courseInfoMediaList = new ArrayList<>();
            List<CourseResponses.CourseLocation> courseLocationsList = new ArrayList<>();
            List<CourseResponses.DiscountDTO> DiscountDTOList = new ArrayList<>();
            CourseResponses courseResponse = CourseMapper.ModelmapToDTO(course, CourseResponses.class);
            courseResponse.setId(course.getId());
            courseResponse.setTeacher(course.getTeacher().getFull_name());
            for (CourseEnrollment enrollment : course.getEnrolledStudents())
            {
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
                    if (existingDiscountDTO.getId() == discountDTO.getId()) {
                        isAlreadyExists = true;
                        break;
                    }
                }
                if (!isAlreadyExists) {
                    DiscountDTOList.add(discountDTO);
                    tempDiscountList.add(discountDTO);
                }
            }
            for (CourseMediaInfo courseMediaInfo : course.getCourseOnlineInfos())
            {
                if(courseMediaInfo.getCourse().equals(course)){
                    CourseResponses.CourseMediaInfo courseInfoMedia = CourseMediaMapper.ModelmapToDTO(courseMediaInfo, CourseResponses.CourseMediaInfo.class);
                    courseInfoMedia.setId(courseMediaInfo.getId());
                    courseInfoMediaList.add(courseInfoMedia);
                }
            }
            for (CourseLocation courseLocation : course.getCourseLocation())
            {
                CourseResponses.CourseLocation courseLocal = CourseLocationMapper.ModelmapToDTO(courseLocation, CourseResponses.CourseLocation.class);
                courseLocal.setId(courseLocation.getId());
                if(courseLocation.getLocations()!=null){

                    Long locationId = courseLocation.getLocations().getId();
                    CourseResponses.CourseLocation.locationResponse location =
                            locationMapper.ModelmapToDTO(courseLocation.getLocations(), CourseResponses.CourseLocation.locationResponse.class);
                    location.setId(locationId);

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
    public User getCurrentUserDetails() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof String Email) {
            Optional<User>  userOption = userRepository.findByEmail(Email);
            return userOption.orElseGet(User::new);
        }
        return null;
    }

    @Override
    public UserInfoResponse userDetail() {
        MapperGeneric<UserAddresses, UserInfoResponse.UserAddress> UserAddressMapper = new MapperGeneric<>();
        MapperGeneric<User, UserInfoResponse> UserMapper = new MapperGeneric<>();
        MapperGeneric<UserBanking, UserInfoResponse.UserBank> UserBankMapper = new MapperGeneric<>();
        User user = getCurrentUserDetails();
        Optional<User> userOption = userRepository.findByEmailWithAddresses(user.getEmail());
        if(userOption.isPresent()){
            User userFull = userOption.get();
            List<UserInfoResponse.UserAddress> userAddressesList = new ArrayList<>();
            List<String>list = new ArrayList<>();
            for (Roles roles : userFull.getRoles()){
                list.add(roles.getName());
            }
            for(UserAddresses addresses : userFull.getUserAddresses())
            {
                UserInfoResponse.UserAddress userAddress = UserAddressMapper.ModelmapToDTO(addresses,UserInfoResponse.UserAddress.class);
                userAddress.setId(addresses.getId());
                userAddressesList.add(userAddress);
            }
            List<UserInfoResponse.UserBank> userBankList = new ArrayList<>();
            for(UserBanking userBanking : userFull.getUserBanks()){
                UserInfoResponse.UserBank userBank = UserBankMapper.ModelmapToDTO(userBanking,UserInfoResponse.UserBank.class);
                userBank.setId(userBanking.getId());
                userBankList.add(userBank);
            }
            UserInfoResponse userInfoResponse = UserMapper.ModelmapToDTO(userFull,UserInfoResponse.class);
            userInfoResponse.setId(userFull.getId());
            userInfoResponse.setRoles(list);
            userInfoResponse.setUserBanks(userBankList);
            userInfoResponse.setUserAddresses(userAddressesList);
            return userInfoResponse;
        }else{
            return new UserInfoResponse();
        }
    }

}
