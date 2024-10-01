create table location
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    address            varchar(255),
    description        varchar(255),
    name               varchar(255),
    status_available   varchar(255)
);

alter table location
    owner to postgres;

create table payment_method
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    description        varchar(255),
    name               varchar(255)
);

alter table payment_method
    owner to postgres;

create table roles
(
    id   bigint not null
        primary key,
    name varchar(255)
);

alter table roles
    owner to postgres;

create table users
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    balance            double precision,
    email              varchar(255)
        constraint uk_sx468g52bpetvlad2j9y0lptc
            unique,
    full_name          varchar(255),
    gender             varchar(255),
    image_url          varchar(255),
    is_enable          boolean not null,
    password           varchar(255),
    phone_number       varchar(255),
    user_name          varchar(255)
);

alter table users
    owner to postgres;

create table course
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    description        varchar(255),
    end_date           timestamp(6),
    is_public          boolean          not null,
    name               varchar(255),
    price              double precision not null,
    start_date         timestamp(6),
    student_count      integer          not null,
    type               varchar(255),
    teacher_id         bigint
        constraint fkbhmlx82vjuwypl8dmfnrbjfhu
            references users
);

alter table course
    owner to postgres;

create table course_enrollments
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    enrollment_date    timestamp(6),
    course_id          bigint not null
        constraint fkrk0d1a7wqlqao0ypno720c0sb
            references course
            on delete cascade,
    student_id         bigint not null
        constraint fkn0fy1fut1f7j4kxwxfl925qnd
            references users
);

alter table course_enrollments
    owner to postgres;

create table course_locations
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    area               varchar(255),
    schedule_date      timestamp(6),
    course_id          bigint not null
        constraint fkr4ssftaltphx175ihcm626qdp
            references course
            on delete cascade,
    location_id        bigint
        constraint fkj8opnh8mtwky2mbfexd5yahga
            references location
            on delete cascade
);

alter table course_locations
    owner to postgres;

create table course_media_info
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    thumbnail_src      varchar(255),
    title              varchar(255),
    url_image          varchar(255),
    url_media          varchar(255),
    course_id          bigint
        constraint fkq4wiqiecxrxr54oqc29w9420f
            references course
            on delete cascade
);

alter table course_media_info
    owner to postgres;

create table discount
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    description        varchar(255),
    name               varchar(255),
    remaining_uses     integer not null,
    value_discount     integer not null,
    user_id            bigint
        constraint fkf0yuaou3xo6mxbdowl2lfycn7
            references users
);

alter table discount
    owner to postgres;

create table course_discounts
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    code               varchar(255),
    quantity           integer not null,
    redemption_date    timestamp(6),
    status             varchar(255)
        constraint course_discounts_status_check
            check ((status)::text = ANY
                   ((ARRAY ['NotAvailable'::character varying, 'Available'::character varying, 'Email_Sent'::character varying])::text[])),
    course_id          bigint
        constraint fk89l6nlksmlmt41urhxi0ilo2s
            references course
            on delete cascade,
    discount_id        bigint
        constraint fkrdc4n7cibwggrw2ubyo20n1aj
            references discount
            on delete cascade
);

alter table course_discounts
    owner to postgres;

create table enrollment
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    enrollment_date    timestamp(6),
    course_id          bigint
        constraint fkbhhcqkw1px6yljqg92m0sh2gt
            references course,
    student_id         bigint
        constraint fkl16dtl7cgm3p2kfip5pml5jsh
            references users
);

alter table enrollment
    owner to postgres;

create table qr_token
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    email              varchar(255),
    name               varchar(255),
    status             boolean not null,
    url_qr_code        text,
    course_id          bigint
        constraint fkagpkqv7024vd5m1eatrh4s1so
            references course
            on delete cascade,
    user_id            bigint
        constraint fkoxdwyrttg8tdgvsjeuapvu9m0
            references users
            on delete cascade
);

alter table qr_token
    owner to postgres;

create table requesttb
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    status             varchar(255)
        constraint requesttb_status_check
            check ((status)::text = ANY
                   ((ARRAY ['PENDING'::character varying, 'APPROVED'::character varying, 'REJECTED'::character varying, 'CANCEL'::character varying])::text[])),
    type               varchar(255)
        constraint requesttb_type_check
            check ((type)::text = ANY
                   ((ARRAY ['DEPOSIT'::character varying, 'BUY_COURSE'::character varying, 'BUY_WORKSHOP'::character varying, 'WITHDRAW'::character varying, 'HANDLE_WITHDRAW'::character varying, 'REGISTER_COURSE_OFFLINE'::character varying])::text[])),
    value              double precision not null,
    course_id          bigint
        constraint fkc85sahueb1oj9ju4aq06lvguw
            references course
            on delete cascade,
    location_id        bigint
        constraint fkk13bk3utm2c5yt2i1g5nmi7r3
            references location,
    user_id            bigint
        constraint fkaotxb9g3p0dxmhm35gip282qm
            references users
);

alter table requesttb
    owner to postgres;

create table transactions
(
    id                   bigserial
        primary key,
    created_by           varchar(255),
    created_date         timestamp(6),
    last_modified_by     varchar(255),
    last_modified_date   timestamp(6),
    amount               double precision not null,
    status               varchar(255)
        constraint transactions_status_check
            check ((status)::text = ANY
                   ((ARRAY ['PENDING'::character varying, 'COMPLETED'::character varying, 'FAILED'::character varying, 'CANCELED'::character varying, 'REFUND'::character varying])::text[])),
    transaction_date     timestamp(6),
    type                 varchar(255)
        constraint transactions_type_check
            check ((type)::text = ANY
                   ((ARRAY ['DEPOSIT'::character varying, 'BUY_COURSE'::character varying, 'BUY_WORKSHOP'::character varying, 'WITHDRAW'::character varying])::text[])),
    course_enrollment_id bigint
        constraint fkjqvflvyq4xi2lmrqo4td8abui
            references course_enrollments
            on delete cascade,
    enrollment_id        bigint
        constraint fk2ruoiw0cbe1vlm7twvh3thf4e
            references enrollment,
    payment_method_id    bigint
        constraint fke9tgpron6q62ei4ot9hbby9x4
            references payment_method,
    request_id           bigint
        constraint fkd4f6m2wrx4owaqggwyw6amdpe
            references requesttb,
    user_id              bigint
        constraint fkqwv7rmvc8va8rep7piikrojds
            references users
);

alter table transactions
    owner to postgres;

create table user_address
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    address            varchar(255),
    city               varchar(255),
    postal_code        integer not null,
    state              varchar(255),
    user_fk_id         bigint
        constraint fkql6gjw8a2d0whvb9u1d06xue0
            references users
);

alter table user_address
    owner to postgres;

create table user_likes
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    teacher_id         bigint
        constraint fk8omlhwbvh06ordh214e5ag96i
            references users,
    user_id            bigint not null
        constraint fk6aog39hkl1hs1amxef5i9g4fv
            references users,
    workshop_id        bigint
        constraint fkp649r4xvo99ndx30l4dtc6bjl
            references course
);

alter table user_likes
    owner to postgres;

create table user_ratings
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    comment            varchar(5000),
    rating             double precision,
    teacher_id         bigint
        constraint fkhm19njxg3j0f6s9mxwob7t00r
            references users,
    user_id            bigint not null
        constraint fk79iiaqgo1bq1whumiv3evhfos
            references users,
    workshop_id        bigint
        constraint fk9a2s9hs51rc1a3ge1lsij3ou1
            references course
);

alter table user_ratings
    owner to postgres;

create table users_bank
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    bank_account       varchar(255),
    bank_name          varchar(255),
    user_id            bigint not null
        constraint fk8vg18tu3e0ymgsjyo138jkdw7
            references users
);

alter table users_bank
    owner to postgres;

create table users_role
(
    user_id  bigint not null
        constraint fkqpe36jsen4rslwfx5i6dj2fy8
            references users,
    roles_id bigint not null
        constraint fks4q7p6d4h57198j5v0su068jq
            references roles,
    primary key (user_id, roles_id)
);

alter table users_role
    owner to postgres;

create table verification_token
(
    id                 bigserial
        primary key,
    created_by         varchar(255),
    created_date       timestamp(6),
    last_modified_by   varchar(255),
    last_modified_date timestamp(6),
    expiration_time    timestamp(6),
    token              varchar(255),
    user_id            bigint
        constraint uk_q6jibbenp7o9v6tq178xg88hg
            unique
        constraint fk3asw9wnv76uxu3kr1ekq4i1ld
            references users
);

alter table verification_token
    owner to postgres;


