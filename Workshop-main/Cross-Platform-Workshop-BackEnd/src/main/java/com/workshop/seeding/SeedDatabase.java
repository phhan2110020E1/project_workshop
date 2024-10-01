package com.workshop.seeding;


import com.workshop.model.*;
import com.workshop.model.courseModel.*;
import com.workshop.model.userModel.*;
import com.workshop.repositories.Course.*;
import com.workshop.repositories.*;
import com.workshop.repositories.User.*;
import com.workshop.service.LocationService;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import com.workshop.service.UserService;

import java.io.*;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Service
@RequiredArgsConstructor
public class SeedDatabase {
    private final UserService userService;
    private final UserRepository userRepository;
    private final UserBankRepository userBankRepository;
    private final UserAddressRepository userAddressRepository;
    private final RoleRepository roleRepository;
    private final CourseRepository courseRepository;
    private final LocationService locationService;
    private final CourseMediaInfoRepository courseMediaInfoRepository;
    private final CourseLocationRepository courseLocationRepository;
    private final CourseEnrollmentRepository courseEnrollmentRepository;
    private final DiscountRepository discountRepository;
    private final CourseDiscountRepository courseDiscountRepository;
    private final LocationRepository locationRepository;
    private static final String SEED_STATUS_FILE_PATH = "seed_status.txt";

    private boolean isSeedCompleted() {
        return new File(SEED_STATUS_FILE_PATH).exists();
    }

    private void createSeedStatusFile() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(SEED_STATUS_FILE_PATH))) {
            writer.write("Seed has run and completed");
            System.out.println("Seed status file created successfully");
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    @PostConstruct
    public void SeedData() {
        if (isSeedCompleted()) {
            System.out.println("Seed has run before. Do not do it again");
        } else {
            userService.SaveRoles(new Roles(null, "USER"));
            userService.SaveRoles(new Roles(null, "SELLER"));
            userService.SaveRoles(new Roles(null, "ADMIN"));
            addServiceManager();
            addRandomTeachers();
            addLocation();
//           addCourse();
            addWorkshopGuitar();
            addWorkshopArt();
            addWorkshopPottery();
            addWorkshopFlowerArrangement();
            createSeedStatusFile();
        }

    }

    private void addServiceManager() {
        User Manager = new User();
        User Seller = new User();
        User User = new User();
        List<Roles> rolesList = roleRepository.findAll();
        Roles rolesUser = rolesList.get(0);
        Roles rolesSeller = rolesList.get(1);
        Roles rolesAdmin = rolesList.get(2);
        Set<Roles> rolesSetUser = new HashSet<>();
        Set<Roles> rolesSetSeller = new HashSet<>();
        Set<Roles> rolesSetAdmin = new HashSet<>();
        rolesSetUser.add(rolesUser);
        rolesSetSeller.add(rolesSeller);
        rolesSetAdmin.add(rolesAdmin);
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//        String encodedAdminPassword = passwordEncoder.encode("admin64@gmail.com");
//        String encodedManagerPassword = passwordEncoder.encode("han2000@gmail.com");
//        String encodedUserPassword = passwordEncoder.encode("lethanhhieu@gmail.com");
        String encodedAdminPassword = passwordEncoder.encode("lactuong64@gmail.com");
        String encodedManagerPassword = passwordEncoder.encode("shopqh95@gmail.com");
        String encodedUserPassword = passwordEncoder.encode("workshopproject04@gmail.com");
        Manager.setFull_name("Nguyễn Hồng Quân")
                .setBalance(5000.0).setUser_name("HongQuan")
                .setEmail("lactuong64@gmail.com").setPassword(encodedAdminPassword).setImage_url("https://firebasestorage.googleapis.com/v0/b/workshopprojec04.appspot.com/o/workshop%2Fuser_image%2Fquankz.jpg?alt=media&token=bde4ebac-d888-42a5-aca8-3ff1aad253be")
                .setPhoneNumber("0383334196").setGender("male").setRoles(rolesSetAdmin)
                .setEnable(true);
        Seller.setFull_name("Phan Huỳnh Hồng Hân").setBalance(5000.0)
                .setUser_name("Hồng Hân").setEmail("shopqh95@gmail.com")
                .setImage_url("https://firebasestorage.googleapis.com/v0/b/workshopprojec04.appspot.com/o/workshop%2Fuser_image%2Fhancute.jpg?alt=media&token=781bce82-42f0-4b42-b411-6dab72c77db1")
                .setPassword(encodedManagerPassword).setPhoneNumber("097865848")
                .setGender("female").setRoles(rolesSetSeller).setEnable(true);
        User.setFull_name("Lê Thanh Hiếu").setBalance(5000.0)
                .setUser_name("Thanh Hiếu").setEmail("workshopproject04@gmail.com").setImage_url("https://firebasestorage.googleapis.com/v0/b/workshopprojec04.appspot.com/o/workshop%2Fuser_image%2Fhieu.jpg?alt=media&token=5f95a1f1-345b-465a-8d83-df4b0105bad5")
                .setPassword(encodedUserPassword).setPhoneNumber("9833241764")
                .setGender("male").setRoles(rolesSetUser).setEnable(true);
        userRepository.save(Manager);
        userRepository.save(Seller);
        userRepository.save(User);
    }

    private void addRandomTeachers() {
        String[] names = {"John", "Alice", "Bob", "Emily", "Michael", "Sarah", "David", "Olivia", "Daniel", "Sophia", "William", "Emma", "James", "Ava", "Matthew", "Chloe", "Jacob", "Mia", "Ethan", "Lily"};
        String[] genders = {"male", "female"};
        String[] bankName = {"ACB", "TechComBank", "DongA", "SCB", "AriBank", "VietComBank", "BIDV", "VieTinBank", "Sacombank", "MBBank", "Eximbank", "VPBank", "TPBank", "HDBank", "Agribank", "SeABank", "OceanBank", "MSB", "SHB", "NamABank", "VIB", "PVcomBank", "GPBank", "BacABank", "KienLongBank", "NCB", "ABBANK", "PGBank", "VietABank", "SCOM", "TPB", "LienvietPostBank", "VRB", "CBBank", "OCB", "LienVietBank", "ABBank", "BaoVietBank", "BVB", "VietBank", "UOB Vietnam", "Keb Hana Bank", "Shinhan Bank Vietnam", "HSBC Vietnam", "ANZ Bank Vietnam"};
        List<Roles> roles = roleRepository.findAll();
        Random random = new Random();
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        for (int i = 0; i < 20; i++) {
            String randomName = names[random.nextInt(names.length)];

            String randomGender = genders[random.nextInt(genders.length)];
            Roles randomRoles = roles.get(random.nextInt(roles.size()));
            Double randomNumber = Math.random() * 500.00;
            DecimalFormat decimalFormat = new DecimalFormat("#.##");
            Double formattedNumber = Double.valueOf(decimalFormat.format(randomNumber));
            String username = "teacher" + (i + 1);
            String email = username + "@gmail.com";
            String password = "12345";
            String phone = "0383334195";
            String encodedPassword = passwordEncoder.encode(password);
            User user = new User();
            Set<Roles> rolesSet = new HashSet<>();
            rolesSet.add(randomRoles); // Assuming Roles is an enum

            user.setRoles(rolesSet);
            user.setUser_name(randomName)
                    .setFull_name(randomName)
                    .setEmail(email)
                    .setPassword(encodedPassword)
                    .setPhoneNumber(phone)
                    .setGender(randomGender).setBalance(formattedNumber)
                    .setEnable(true);
            userRepository.save(user);
            for (int j = 0; j < 3; j++) {
                UserAddresses address = new UserAddresses();
                address.setAddress("Street " + (j + 1));
                address.setCity("City " + (j + 1));
                address.setState("State " + (j + 1));
                address.setPostalCode(12345 * (j + 4));
                address.setUser(user);
                userAddressRepository.save(address);
            }
            for (int j = 0; j < 3; j++) {
                UserBanking userBanking = new UserBanking();
                UUID randomUUID = UUID.randomUUID();
                String randomBankAccountCode = randomUUID.toString().replaceAll("[^0-9]", "");
                String randomBank = bankName[random.nextInt(bankName.length)];
                userBanking.setBankAccount(randomBankAccountCode)
                        .setBankName(randomBank);
                userBanking.setUser(user);
                userBankRepository.save(userBanking);
            }
        }
    }

    private void addLocation() {
        locationService.AddLocation(new Location("Adora Plaza", "Quận 1", "Trung Tâm 1", "pending", null, null));
        locationService.AddLocation(new Location("Diamond Center", "Quận 1", "Trung Tâm 2", "available", null, null));
        locationService.AddLocation(new Location("Vin-com Center", "Quận 1", "Trung Tâm 3", "pending", null, null));
        locationService.AddLocation(new Location("BlackPear Plaza", "Quận 2", "Trung Tâm 1", "available", null, null));
        locationService.AddLocation(new Location("Mega Mall", "Quận 2", "Trung Tâm 2", "pending", null, null));
        locationService.AddLocation(new Location("Riverside Shopping", "Quận 2", "Trung Tâm 3", "available", null, null));
        locationService.AddLocation(new Location("VinCom Plaza", "Quận 3", "Trung Tâm 1", "available", null, null));
        locationService.AddLocation(new Location("Crescent Mall", "Quận 3", "Trung Tâm 2", "available", null, null));
        locationService.AddLocation(new Location("Takayoshi", "Quận 3", "Trung Tâm 3", "available", null, null));
        locationService.AddLocation(new Location("Now Zone", "Quận 4", "Trung Tâm 1", "pending", null, null));
        locationService.AddLocation(new Location("Pearl Plaza", "Quận 4", "Trung Tâm 2", "available", null, null));
        locationService.AddLocation(new Location("Saigon Paragon Mall", "Quận 4", "Trung Tâm 3", "available", null, null));
        locationService.AddLocation(new Location("Lotte Mart", "Quận 5", "Trung Tâm 1", "pending", null, null));
        locationService.AddLocation(new Location("Pandora City", "Quận 5", "Trung Tâm 2", "available", null, null));
        locationService.AddLocation(new Location("An Dong Plaza", "Quận 5", "Trung Tâm 3", "disable", null, null));
        locationService.AddLocation(new Location("Now Mega Mall", "Quận 6", "Trung Tâm 1", "disable", null, null));
        locationService.AddLocation(new Location("Parks CT Plaza", "Quận 6", "Trung Tâm 2", "disable", null, null));
        locationService.AddLocation(new Location("CitiMart Shopping", "Quận 6", "Trung Tâm 3", "disable", null, null));
        locationService.AddLocation(new Location("SC VivCity", "Quận 7", "Trung Tâm 1", "available", null, null));
        locationService.AddLocation(new Location("Crescent Mall 2", "Quận 7", "Trung Tâm 2", "available", null, null));
        locationService.AddLocation(new Location("Lotte Mart 2", "Quận 7", "Trung Tâm 3", "available", null, null));
        locationService.AddLocation(new Location("AEON Mall Tan Phu Celadon", "Quận 8", "pending", "Trung Tâm 1", null, null));
        locationService.AddLocation(new Location("The Garden Mall", "Quận 8", "Trung Tâm 2", "disable", null, null));
        locationService.AddLocation(new Location("Dragon Mall", "Quận 8", "Trung Tâm 3", "disable", null, null));
        locationService.AddLocation(new Location("Vin-com Mega Mall", "Quận 9", "Trung Tâm 1", "available", null, null));
        locationService.AddLocation(new Location("Crescent Mall 3", "Quận 9", "Trung Tâm 2", "available", null, null));
        locationService.AddLocation(new Location("Takayoshi 2", "Quận 9", "Trung Tâm 3", "available", null, null));
        locationService.AddLocation(new Location("Now Zone 2", "Quận 10", "Trung Tâm 1", "available", null, null));
        locationService.AddLocation(new Location("Parks Shopping", "Quận 10", "Trung Tâm 2", "available", null, null));
        locationService.AddLocation(new Location("Central Square", "Quận 10", "Trung Tâm 3", "available", null, null));
        locationService.AddLocation(new Location("Lotte Mart 3", "Quận 11", "Trung Tâm 1", "available", null, null));
        locationService.AddLocation(new Location("AEON Mall 2", "Quận 11", "Trung Tâm 2", "available", null, null));
        locationService.AddLocation(new Location("Mega Plaza", "Quận 11", "Trung Tâm 3", "available", null, null));
        locationService.AddLocation(new Location("Vin-com Mega Mall 2", "Quận 12", "Trung Tâm 1", "available", null, null));
        locationService.AddLocation(new Location("CitiMart 2", "Quận 12", "Trung Tâm 2", "available", null, null));
        locationService.AddLocation(new Location("Super Plaza", "Quận 12", "Trung Tâm 3", "available", null, null));
    }
    private void addWorkshopFlowerArrangement() {
        List<User> teachers = userRepository.findUsersByRoleName("SELLER");
        User randomTeacher = teachers.get(new Random().nextInt(teachers.size()));
        LocalDateTime currentDateTime = LocalDateTime.now();
        Timestamp startDate = Timestamp.valueOf(currentDateTime);
        LocalDateTime endDate = currentDateTime.plus(4, ChronoUnit.DAYS);
        Timestamp endDateTimestamp = Timestamp.valueOf(endDate);
        String[] ListTitle = {
                "Learn the basics of floral design for beginners.",
                "Create beautiful flower arrangements for different seasons.",
                "Explore the art of floral design for weddings and events.",
                "Master the ancient Japanese art of Ikebana flower arranging.",
        };
        Random random = new Random();
        Course course = new Course();
        course.setName("SeasonalArrangements")
                .setDescription("Create beautiful flower arrangements for different seasons")
                .setPrice(400)
                .setPublic(true)
                .setType("offline").setTeacher(randomTeacher)
                .setStartDate(startDate).setEndDate(endDateTimestamp);
        courseRepository.save(course);
        for (int j = 0; j < 3; j++) {
            String randomTitle = ListTitle[random.nextInt(ListTitle.length)];
            CourseMediaInfo courseMediaInfo = new CourseMediaInfo();
            courseMediaInfo.setUrlMedia("https://firebasestorage.googleapis.com/v0/b/workshopprojec04.appspot.com/o/workshop%2Fvideo%2Fworkshophoa.mp4?alt=media&token=02d0bbf6-c5b7-4007-a740-373c8001ee51")
                    .setTitle(randomTitle)
                    .setUrlImage("https://firebasestorage.googleapis.com/v0/b/workshopprojec04.appspot.com/o/workshop%2Fimage%2Fworkshop%20cam%20hoa.png?alt=media&token=4b67b688-5d7d-42d5-a05a-763ddd0d2caf")
                    .setThumbnailSrc("https://firebasestorage.googleapis.com/v0/b/workshopprojec04.appspot.com/o/workshop%2Fimage%2Fworkshop%20cam%20hoa.png?alt=media&token=4b67b688-5d7d-42d5-a05a-763ddd0d2caf")
                    .setCourse(course);
            courseMediaInfoRepository.save(courseMediaInfo);
        }
        List<Location> location = locationRepository.findAll();
        Location randomlocation = location.get(new Random().nextInt(location.size()));
        CourseLocation courseLocation = new CourseLocation();
        courseLocation.setCourses(course).setArea(randomlocation.getAddress()).setSchedule_Date(startDate).setLocations(randomlocation);
        courseLocationRepository.save(courseLocation);
        String randomName = "Discount WeddingFloralWorkshop ";
        String randomDescription = "Master the ancient Japanese art of Ikebana flower arranging";
        int randomValueDiscount = random.nextInt(10) + 5;
        int randomRemainingUses = random.nextInt(10);
        Discount discount = new Discount();
        discount.setRemainingUses(randomRemainingUses)
                .setValueDiscount(randomValueDiscount).
                setName(randomName).setDescription(randomDescription);
        discountRepository.save(discount);
        for (int f = 0; f < randomValueDiscount; f++) {
            UUID randomUUID = UUID.randomUUID();
            String randomDiscountCode = randomUUID.toString();
            CourseDiscount courseDiscount = new CourseDiscount();
            int n = random.nextInt(30);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            calendar.add(Calendar.DAY_OF_MONTH, n);
            Date redemptionDate = calendar.getTime();
            courseDiscount
                    .setCode(randomDiscountCode).setStatus(CourseDiscount.Status.Available)
                    .setCourse(course).setDiscount(discount).setQuantity(randomValueDiscount).setRedemptionDate(redemptionDate);
            courseDiscountRepository.save(courseDiscount);
        }
    }
    private void addWorkshopPottery() {
        List<User> teachers = userRepository.findUsersByRoleName("SELLER");
        User randomTeacher = teachers.get(new Random().nextInt(teachers.size()));
        LocalDateTime currentDateTime = LocalDateTime.now();
        Timestamp startDate = Timestamp.valueOf(currentDateTime);
        LocalDateTime endDate = currentDateTime.plus(4, ChronoUnit.DAYS);
        Timestamp endDateTimestamp = Timestamp.valueOf(endDate);
        String[] ListTitle = {
                "Introduction to basic handbuilding techniques in ceramics.",
                "Master the art of wheel throwing to create pottery.",
                "Experience the unique and exciting Raku firing process.",
                "Create sculptural pieces using advanced ceramics techniques.",
        };
        Random random = new Random();
        Course course = new Course();
        course.setName("WheelThrowingWorkshop")
                .setDescription("Master the art of wheel throwing to create pottery")
                .setPrice(100)
                .setPublic(true)
                .setType("offline").setTeacher(randomTeacher)
                .setStartDate(startDate).setEndDate(endDateTimestamp);
        courseRepository.save(course);
        for (int j = 0; j < 3; j++) {
            String randomTitle = ListTitle[random.nextInt(ListTitle.length)];
            CourseMediaInfo courseMediaInfo = new CourseMediaInfo();
            courseMediaInfo.setUrlMedia("https://firebasestorage.googleapis.com/v0/b/workshopprojec04.appspot.com/o/workshop%2Fvideo%2Fworkshop%20art.mp4?alt=media&token=11276c48-ab9c-44d4-b403-12569cbddf1a")
                    .setTitle(randomTitle)
                    .setUrlImage("https://firebasestorage.googleapis.com/v0/b/workshopprojec04.appspot.com/o/workshop%2Fimage%2Fworkshop%20lam%20gom.png?alt=media&token=aaee9a63-4bd7-4afb-900e-bfa4d2de052a")
                    .setThumbnailSrc("https://firebasestorage.googleapis.com/v0/b/workshopprojec04.appspot.com/o/workshop%2Fimage%2Fworkshop%20lam%20gom.png?alt=media&token=aaee9a63-4bd7-4afb-900e-bfa4d2de052a")
                    .setCourse(course);
            courseMediaInfoRepository.save(courseMediaInfo);
        }
        List<Location> location = locationRepository.findAll();
        Location randomlocation = location.get(new Random().nextInt(location.size()));
        CourseLocation courseLocation = new CourseLocation();
        courseLocation.setCourses(course).setArea(randomlocation.getAddress()).setSchedule_Date(startDate).setLocations(randomlocation);
        courseLocationRepository.save(courseLocation);
        String randomName = "Discount Handbuilding101 ";
        String randomDescription = "Create sculptural pieces using advanced ceramics techniques";
        int randomValueDiscount = random.nextInt(10) + 5;
        int randomRemainingUses = random.nextInt(10);
        Discount discount = new Discount();
        discount.setRemainingUses(randomRemainingUses)
                .setValueDiscount(randomValueDiscount).
                setName(randomName).setDescription(randomDescription);
        discountRepository.save(discount);
        for (int f = 0; f < randomValueDiscount; f++) {
            UUID randomUUID = UUID.randomUUID();
            String randomDiscountCode = randomUUID.toString();
            CourseDiscount courseDiscount = new CourseDiscount();
            int n = random.nextInt(30);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            calendar.add(Calendar.DAY_OF_MONTH, n);
            Date redemptionDate = calendar.getTime();
            courseDiscount
                    .setCode(randomDiscountCode).setStatus(CourseDiscount.Status.Available)
                    .setCourse(course).setDiscount(discount).setQuantity(randomValueDiscount).setRedemptionDate(redemptionDate);
            courseDiscountRepository.save(courseDiscount);
        }
    }
    private void addWorkshopArt() {
        List<User> teachers = userRepository.findUsersByRoleName("SELLER");
        User randomTeacher = teachers.get(new Random().nextInt(teachers.size()));
        LocalDateTime currentDateTime = LocalDateTime.now();
        Timestamp startDate = Timestamp.valueOf(currentDateTime);
        LocalDateTime endDate = currentDateTime.plus(4, ChronoUnit.DAYS);
        Timestamp endDateTimestamp = Timestamp.valueOf(endDate);
        String[] ListTitle = {
                "Learn the techniques of abstract painting.",
                "Hands-on experience in creating sculptures.",
                "Master the world of digital art and graphic design.",
                "Discover the beauty of oil painting on canvas.",
        };
        Random random = new Random();
        Course course = new Course();
        course.setName("AbstractPainting")
                .setDescription("Learn the techniques of abstract painting")
                .setPrice(200)
                .setPublic(true)
                .setType("offline").setTeacher(randomTeacher)
                .setStartDate(startDate).setEndDate(endDateTimestamp);
        courseRepository.save(course);
        for (int j = 0; j < 3; j++) {
            String randomTitle = ListTitle[random.nextInt(ListTitle.length)];
            CourseMediaInfo courseMediaInfo = new CourseMediaInfo();
            courseMediaInfo.setUrlMedia("https://firebasestorage.googleapis.com/v0/b/workshopprojec04.appspot.com/o/workshop%2Fvideo%2Fworkshop%20art.mp4?alt=media&token=11276c48-ab9c-44d4-b403-12569cbddf1a")
                    .setTitle(randomTitle)
                    .setUrlImage("https://firebasestorage.googleapis.com/v0/b/workshopprojec04.appspot.com/o/workshop%2Fimage%2Fworkshop%20ve%20tranh.png?alt=media&token=4b4624cd-3b97-4228-8337-41f1e19b4f27")
                    .setThumbnailSrc("https://firebasestorage.googleapis.com/v0/b/workshopprojec04.appspot.com/o/workshop%2Fimage%2Fworkshop%20ve%20tranh.png?alt=media&token=4b4624cd-3b97-4228-8337-41f1e19b4f27")
                    .setCourse(course);
            courseMediaInfoRepository.save(courseMediaInfo);
        }
        List<Location> location = locationRepository.findAll();
        Location randomlocation = location.get(new Random().nextInt(location.size()));
        CourseLocation courseLocation = new CourseLocation();
        courseLocation.setCourses(course).setArea(randomlocation.getAddress()).setSchedule_Date(startDate).setLocations(randomlocation);
        courseLocationRepository.save(courseLocation);
        String randomName = "Discount DigitalArtMaster ";
        String randomDescription = "Master the world of digital art and graphic design. ";
        int randomValueDiscount = random.nextInt(10) + 5;
        int randomRemainingUses = random.nextInt(10);
        Discount discount = new Discount();
        discount.setRemainingUses(randomRemainingUses)
                .setValueDiscount(randomValueDiscount).
                setName(randomName).setDescription(randomDescription);
        discountRepository.save(discount);
        for (int f = 0; f < randomValueDiscount; f++) {
            UUID randomUUID = UUID.randomUUID();
            String randomDiscountCode = randomUUID.toString();
            CourseDiscount courseDiscount = new CourseDiscount();
            int n = random.nextInt(30);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            calendar.add(Calendar.DAY_OF_MONTH, n);
            Date redemptionDate = calendar.getTime();
            courseDiscount
                    .setCode(randomDiscountCode).setStatus(CourseDiscount.Status.Available)
                    .setCourse(course).setDiscount(discount).setQuantity(randomValueDiscount).setRedemptionDate(redemptionDate);
            courseDiscountRepository.save(courseDiscount);
        }
    }
    private void addWorkshopGuitar() {
        List<User> teachers = userRepository.findUsersByRoleName("SELLER");
        User randomTeacher = teachers.get(new Random().nextInt(teachers.size()));
        LocalDateTime currentDateTime = LocalDateTime.now();
        Timestamp startDate = Timestamp.valueOf(currentDateTime);
        LocalDateTime endDate = currentDateTime.plus(4, ChronoUnit.DAYS);
        Timestamp endDateTimestamp = Timestamp.valueOf(endDate);
        String[] ListTitle = {
                "Introduction to Guitar Playing for Beginners",
                "Mastering Advanced Guitar Techniques and Solos.",
                "Deep Dive into Acoustic Guitar Playing and Songwriting.",
                "Explore the Blues: Techniques and Improvisation.",
        };
        Random random = new Random();
        Course course = new Course();
        course.setName("AcousticMastery")
                .setDescription("Mastering Advanced Guitar Techniques and Solos")
                .setPrice(300)
                .setPublic(true)
                .setType("offline").setTeacher(randomTeacher)
                .setStartDate(startDate).setEndDate(endDateTimestamp);
        courseRepository.save(course);
        for (int j = 0; j < 3; j++) {
            String randomTitle = ListTitle[random.nextInt(ListTitle.length)];
            CourseMediaInfo courseMediaInfo = new CourseMediaInfo();
            courseMediaInfo.setUrlMedia("https://firebasestorage.googleapis.com/v0/b/workshopprojec04.appspot.com/o/workshop%2Fvideo%2Fworkshop%20guitar.mp4?alt=media&token=86ce5f30-e39c-4560-8bb2-b06ccd8b93f7")
                    .setTitle(randomTitle)
                    .setUrlImage("https://firebasestorage.googleapis.com/v0/b/workshopprojec04.appspot.com/o/workshop%2Fimage%2Fworkshop%20guitar.png?alt=media&token=69c79783-7e85-4031-ad7d-f5ba9a307525")
                    .setThumbnailSrc("https://firebasestorage.googleapis.com/v0/b/workshopprojec04.appspot.com/o/workshop%2Fimage%2Fworkshop%20guitar.png?alt=media&token=69c79783-7e85-4031-ad7d-f5ba9a307525")
                    .setCourse(course);
            courseMediaInfoRepository.save(courseMediaInfo);
        }
        List<Location> location = locationRepository.findAll();
        Location randomlocation = location.get(new Random().nextInt(location.size()));
        CourseLocation courseLocation = new CourseLocation();
        courseLocation.setCourses(course).setArea(randomlocation.getAddress()).setSchedule_Date(startDate).setLocations(randomlocation);
        courseLocationRepository.save(courseLocation);
        String randomName = "Discount Beginner ";
        String randomDescription = "Explore the Blues: Techniques and Improvisation. ";
        int randomValueDiscount = random.nextInt(10) + 5;
        int randomRemainingUses = random.nextInt(10);
        Discount discount = new Discount();
        discount.setRemainingUses(randomRemainingUses)
                .setValueDiscount(randomValueDiscount).
                setName(randomName).setDescription(randomDescription);
        discountRepository.save(discount);
        for (int f = 0; f < randomValueDiscount; f++) {
            UUID randomUUID = UUID.randomUUID();
            String randomDiscountCode = randomUUID.toString();
            CourseDiscount courseDiscount = new CourseDiscount();
            int n = random.nextInt(30);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            calendar.add(Calendar.DAY_OF_MONTH, n);
            Date redemptionDate = calendar.getTime();
            courseDiscount
                    .setCode(randomDiscountCode).setStatus(CourseDiscount.Status.Available)
                    .setCourse(course).setDiscount(discount).setQuantity(randomValueDiscount).setRedemptionDate(redemptionDate);
            courseDiscountRepository.save(courseDiscount);
        }
    }
}