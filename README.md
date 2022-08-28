# Project : BODYLIKE
- [BODYLUV](https://bodyluv.kr/?cafe_mkt=ue_g_main_sa_own&utm_source=google&utm_medium=sa_own_cpc&utm_campaign=keyword&utm_term=%EB%B0%94%EB%94%94%EB%9F%BD&utm_content=bodyluv_main&gclid=CjwKCAjw3qGYBhBSEiwAcnTRLhhL1emCdcojfoOcM_XEchiM04lG6JcYCNpJsQroNer4_iK7fRzhcBoCJFYQAvD_BwE) 클론 사이트
- 욕실 용품 커머스 서비스
- [BODYLIKE 시연 영상 보러가기](https://youtu.be/_TEbHw0EREg)

<br/>

![BODYLIKE 메인페이지](https://velog.velcdn.com/images/nextlinehappy516/post/0e002503-851f-45c1-82a5-9f197f38e640/image.png)

<br/>

<hr/>

## 개발 기간

<br/>

- 2022-08-16 ~ 2022.08.26 (11일)

<br/>

<hr/>

## 기술 스택

<br/>

<img src="https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=Node.js&logoColor=white"> <img src="https://img.shields.io/badge/Mysql 8.0-4479A1?style=for-the-badge&logo=Mysql&logoColor=white"> <img src="https://img.shields.io/badge/express-000000?style=for-the-badge&logo=express&logoColor=white">


<img src="https://img.shields.io/badge/Nodemon-76D04B?style=for-the-badge&logo=Nodemon&logoColor=white"> <img src="https://img.shields.io/badge/jsonwebtokens-000000?style=for-the-badge&logo=jsonwebtokens&logoColor=white"> <img src="https://img.shields.io/badge/postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white">

<br/>

<hr/>

## 구성원 소개

<br/>

- [백민석](https://github.com/sk8ilar)
- [이지현](https://github.com/LeeJ1Hyun)
- [프론트 엔드 github주소 보러가기](https://github.com/wecode-bootcamp-korea/36-1st-Team-Corner-frontend)

<br/>

<hr/>

## &#127919; 구현 API 및 업무 소개

<br/>

### 이지현
- ERD 모델링
- BULK INSERT 비동기적 구현
  
```
//uploader.js

const dotenv = require("dotenv");
dotenv.config();
const { DataSource, UsingJoinColumnIsNotAllowedError } = require("typeorm");
const fs = require("fs");
const appDataSource = new DataSource({
  type: process.env.TYPEORM_CONNECTION,
  host: process.env.TYPEORM_HOST,
  port: process.env.TYPEORM_PORT,
  username: process.env.TYPEORM_USERNAME,
  password: process.env.TYPEORM_PASSWORD,
  database: process.env.TYPEORM_DATABASE
});

const initializingDataSource = async () => {
  await appDataSource.initialize()
}

const csv = fs.readFileSync("./products.csv", "utf-8");
const rows = csv.split("\n");
rows.shift();

const dataArr = rows.map((val) => {
  let arr = val.split(",");
  return arr;
});

const sql = 'INSERT INTO products (id,name,price,thumbnail_image_url,stock,category_id) VALUES ?';
const bulkInsert = async() => { 
  await initializingDataSource()
  await appDataSource.query(sql, [dataArr])
};

bulkInsert();
```

- 리뷰 API (GET/ POST/ DELETE/ PATCH)
  - transaction을 이용한 pagination 구현

```
const reviewList = async (start, pageSize, productId) => {
  const queryRunner = appDataSource.createQueryRunner();
  await queryRunner.connect();

  await queryRunner.startTransaction();

  try {
    const reviewList = await queryRunner.query(
      `SELECT 
                r.id, 
                r.contents, 
                r.created_at, 
                u.name 
            FROM reviews r 
            LEFT JOIN users u 
            on r.user_id = u.id 
            WHERE r.product_id = ${productId}
            LIMIT ${start},${pageSize}`
    );
    const reviewCount = await queryRunner.query(
      `SELECT count(*) as reviewCount
              FROM reviews
              WHERE product_id = ${productId}`
    );

    await queryRunner.commitTransaction();
    return [reviewList, reviewCount];
  } catch (err) {
    await queryRunner.rollbackTransactrsion();
  } finally {
    await queryRunner.release();
  }
};
```

- 장바구니 담기 (상세페이지) API (POST)
  - 기존 데이터 베이스 검사를 통하여 추가로 담기 기능 구현

<br/>

## 프로젝트 하면서 집중했던 것
- RESTful endpoint
- DATABASE modeling
  
<br/>

<hr/>

## &#128218; 팀 프로젝트 자료

<br/>

### ERD

<br/>

![BODYLIKE ERD](https://velog.velcdn.com/images/nextlinehappy516/post/041ac237-e0e5-456f-9998-f0837882e96a/image.png)


<br/>

### TERLLO

<br/>

![BODYLIKE TRELLO](https://velog.velcdn.com/images/nextlinehappy516/post/e06ffb60-b22e-46bf-8020-f58221f442d8/image.png)


<br/>

### API 명세서

<br/>

![BODYLIKE API](https://velog.velcdn.com/images/nextlinehappy516/post/76a07050-23b1-474e-8770-4fb954b0ab6f/image.png)


&#128073; [API 명세서 보러가기](https://docs.google.com/spreadsheets/d/1DuK0H7zI5MEbLEHq-3Y106uThtfh0ihKpdWViosK0UE/edit?usp=sharing)
<br/>
