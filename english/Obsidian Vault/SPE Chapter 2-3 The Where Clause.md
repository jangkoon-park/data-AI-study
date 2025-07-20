
### 전체 문장

After accessing the index, the database must do one more step to fetch the queried data (FIRST_NAME, LAST_NAME) from the table storage:  
인덱스에 접근한 후, 데이터베이스는 테이블 저장소에서 조회한 데이터(FIRST_NAME, LAST_NAME)를 가져오기 위해 한 번 더 절차를 수행해야 한다.

---

구문 및 단어 해석

- After accessing the index : 인덱스에 접근한 후에
    
- the database : 데이터베이스는
    
- must do one more 🔴step : 한 번 더 절차를 수행해야 한다
    
-🔴 to fetch : 가져오기 위해
    
- the queried data (FIRST_NAME, LAST_NAME) : 조회한 데이터(FIRST_NAME, LAST_NAME)를
    
- from the table storage : 테이블 저장소(테이블)에서
    

---

문장 구조 (한국어 트리 형태, 나열)

- [인덱스에 접근한 후에]  
    └─ [데이터베이스는]  
       └─ [한 번 더 절차를 수행해야 한다]  
         └─ [가져오기 위해]  
           └─ [조회한 데이터(FIRST_NAME, LAST_NAME)를]  
             └─ [테이블 저장소에서]

### 전체 문장

This operation can become a performance bottleneck—as explained in “Slow Indexes, Part I”—but there is no such risk in connection with an INDEX UNIQUE SCAN.  
이 작업은 “느린 인덱스, 1부”에서 설명한 것처럼 성능 병목이 될 수 있지만, INDEX UNIQUE SCAN과 관련해서는 그런 위험이 없다.

구문 및 단어 해석  
This operation : 이 작업은  
can become : ~이 될 수 있다  
🔴a performance bottleneck : 성능 병목  
as explained in “Slow Indexes, Part I” : “느린 인덱스, 1부”에서 설명한 것처럼  
but : 하지만  
🔴there is no such risk : 그런 위험은 없다  
in connection with : ~와 관련해서는  
an INDEX UNIQUE SCAN : INDEX UNIQUE SCAN

문장 구조 (한국어 트리 형태, 나열)  
[이 작업은]  
└─ [성능 병목이 될 수 있다]  
 └─ [“느린 인덱스, 1부”에서 설명한 것처럼]  
 └─ [하지만]  
  └─ [INDEX UNIQUE SCAN과 관련해서는]  
   └─ [그런 위험은 없다]

### 전체 문장

This operation cannot deliver more than one entry so it cannot trigger more than one table access  
이 작업은 하나 이상의 엔트리를 반환할 수 없으므로, 하나 이상의 테이블 접근을 발생시킬 수 없다.

구문 및 단어 해석  
This operation : 이 작업은  
cannot deliver more than one entry : 하나 이상의 엔트리를 반환할 수 없다  
so : 그래서, 그러므로  
🔴it cannot trigger : ~를 발생시킬 수 없다  
more than one table access : 하나 이상의 테이블 접근

문장 구조 (한국어 트리 형태, 나열)  
[이 작업은]  
└─ [하나 이상의 엔트리를 반환할 수 없으므로]  
 └─ [하나 이상의 테이블 접근을 발생시킬 수 없다]

**전체 해석**  
이 작업은 하나 이상의 엔트리를 반환할 수 없으므로, 하나 이상의 테이블 접근을 발생시킬 수 없다.

### 전체 문장

One of the reasons for using non-unique indexes for a primary keys are deferrable constraints  
프라이머리 키에 유니크 인덱스가 아닌 인덱스를 사용하는 이유 중 하나는 지연(디퍼러블) 제약조건 때문이다.

---

구문 및 단어 해석  
One of the reasons : 이유 중 하나는  
for using non-unique indexes : 유니크 인덱스가 아닌 인덱스를 사용하는  
for a primary key : 프라이머리 키(기본키)에 대해  
are 🔴ideferrable constraints : 디퍼러블(지연 가능한) 제약조건 때문이다

---

문장 구조 (한국어 트리 형태, 나열)  
[프라이머리 키에 유니크 인덱스가 아닌 인덱스를 사용하는 이유 중 하나는]  
└─ [지연(디퍼러블) 제약조건 때문이다]

---

**전체 해석**  
프라이머리 키에 유니크 인덱스가 아닌 인덱스를 사용하는 이유 중 하나는 지연(디퍼러블) 제약조건 때문이다.

---

#### 💡 참고

- **deferrable constraint(디퍼러블 제약조건)**란  
    트랜잭션이 끝날 때까지 제약조건(예: 유일성)을 “나중에 검사”하도록 설정할 수 있는 기능입니다.  
    이런 경우 일반적인 유니크 인덱스 대신, 비유니크 인덱스와 추가 로직으로 처리할 수 있습니다.
    
- 즉, 반드시 유니크 인덱스만을 프라이머리 키에 쓸 필요가 없는 상황도 있다는 뜻입니다.

### 🌟 전체 문장

Even though the database creates the index for the primary key automatically, there is still room for manual refinements if the key consists of multiple columns.

---

### 🌍 전체 해석

비록 데이터베이스가 기본 키(primary key)에 대한 인덱스를 자동으로 생성하더라도, 만약 그 키가 여러 열로 구성되어 있다면 여전히 수동으로 다듬을 여지가 있다.

---

### 🔍 구문/단어 해석

- **Even though** → 비록 ~일지라도
    
- **database** → 데이터베이스
    
- **creates** → 생성하다
    
- **index** → 인덱스 (데이터베이스 검색용 색인)
    
- **primary key** → 기본 키
    
- **automatically** → 자동으로
    
-🔴 **there is still room for ~** → ~할 여지가 여전히 있다
    
- 🔴**manual refinements** → 수동으로 다듬기, 수동 조정
    
- **if** → 만약
    
- **consists of** → ~로 구성되다
    
- **multiple columns** → 여러 열
    

---

### 🌳 문장 구조 (한국어로 트리 형태)

- [주절]  
    → **There is still room for manual refinements** (여전히 수동 다듬기 여지가 있다)  
     └─ [조건] if the key consists of multiple columns (만약 키가 여러 열로 구성되어 있다면)
    
- [부사절]  
    → Even though the database creates the index for the primary key automatically  
      (비록 데이터베이스가 기본 키용 인덱스를 자동으로 생성하더라도)
    

---

### 💬 정리해서 한국어로 자연스럽게

비록 데이터베이스가 기본 키 인덱스를 자동 생성하더라도,  
만약 그 키가 여러 열로 구성되어 있다면,  
여전히 수동으로 다듬을 여지가 있다.

---

좋아요! 요청하신 대로 이 문장을 분석해줄게요:

---

### 🌟 **전체 문장**

In that case the database creates an index on all primary key columns — a so-called concatenated index.

---

### 🌍 **전체 해석**

그 경우, 데이터베이스는 모든 기본 키 컬럼에 인덱스를 생성하는데, 이것을 소위 **연결 인덱스(concatenated index)**라고 한다.

---

### 🔍 **구문/단어 해석**

- 🔴**In that case** → 그 경우에는
    
- **the database** → 데이터베이스
    
- **creates an index** → 인덱스를 생성한다
    
- **on all primary key columns** → 모든 기본 키 컬럼에 대해
    
- **a so-called concatenated index** → 소위 말하는 연결 인덱스 (concatenated: 연결된, 이어진)
    

---

### 🌳 **문장 구조 (한국어로 트리 형태)**

- [주절]  
    → the database creates an index (데이터베이스가 인덱스를 생성한다)  
     └─ [어디에?] on all primary key columns (모든 기본 키 컬럼에 대해)  
     └─ [그게 무엇인가?] a so-called concatenated index (소위 연결 인덱스라고 불리는 것)
    
- [조건/맥락]  
    → In that case (그 경우에)
    

---

### 💬 **정리해서 한국어로 자연스럽게**

그 경우, 데이터베이스는 모든 기본 키 컬럼에 대해 인덱스를 생성하며,  
이를 소위 **연결 인덱스(concatenated index)**라고 부른다.

---

📌 **보충 설명 (추가로 궁금할까 봐!)**

- **concatenated index**:  
    여러 컬럼을 순서대로 묶어서 만든 하나의 인덱스.  
    예: (col1, col2, col3) → col1 + col2 + col3로 묶어 하나의 인덱스로 검색 최적화.
    

---
### 🌟 **전체 문장**
For the sake of demonstration, let’s assume there is a company merger.

---
### 🌍 **전체 해석**
설명을 위해, 회사 합병이 있다고 가정해보자.

---

### 🔍 **구문/단어 해석**

- 🔴**for the sake of ~** → ~을 위해서, ~을 목적으로
    
- **demonstration** → 시연, 설명, 예시
    
-🔴 **let’s assume ~** → ~라고 가정해보자
    
- **there is ~** → ~가 있다
    
🔴- **company merger** → 회사 합병
    

---

### 🌳 **문장 구조 (한국어로 트리 형태)**

- [주절]  
    → let’s assume (가정해보자)  
     └─ there is a company merger (회사 합병이 있다고)
    
- [부사구]  
    → for the sake of demonstration (설명을 위해서)
    

---

### 💬 **정리해서 한국어로 자연스럽게**

설명을 위해, 회사 합병이 있다고 가정해보자.

---

📌 **보충 설명 (혹시 궁금할까 봐!)**

- **for the sake of demonstration**  
    → 실전에서는 실제 상황이 아니라 예시로 보여주기 위해,  
    예: “이해를 돕기 위해 예를 들면…”
    

---

필요하다면:  
✅ 이 문장을 더 넓혀서 관련 표현/패턴들,  
✅ 비슷한 문장 연습 세트  
도 만들어줄 수 있어요!


좋습니다! 요청하신 문장을 아래처럼 분석해드릴게요.

---

### 🌟 **전체 문장**

We need to extend the primary key by an extra identifier — e.g., a subsidiary ID.

---

### 🌍 **전체 해석**

우리는 기본 키를 추가 식별자(예: 자회사 ID)로 확장할 필요가 있다.

---

### 🔍 **구문/단어 해석**

- **we need to ~** → 우리는 ~할 필요가 있다
    
- **extend ~** → ~을 확장하다
    
- **primary key** → 기본 키
    
- 🔴**by an extra identifier** → 추가 식별자를 통해, 추가 식별자로
    
- 🔴**e.g. (exempli gratia)** → 예를 들어
    
- 🔴**subsidiary ID** → 자회사 ID
    

---

### 🌳 **문장 구조 (한국어로 트리 형태)**

- [주절]  
    → We need to extend the primary key (우리는 기본 키를 확장할 필요가 있다)  
     └─ by an extra identifier (추가 식별자를 통해)
    
- [부연 설명]  
    → e.g., a subsidiary ID (예: 자회사 ID)
    

---

### 💬 **정리해서 한국어로 자연스럽게**

우리는 기본 키를 추가 식별자(예: 자회사 ID)를 통해 확장할 필요가 있다.

---

📌 **보충 설명 (혹시 궁금할까 봐!)**

- **extend the primary key** → 기존 기본 키에 새로운 컬럼을 추가해 유니크한 식별 범위를 늘리는 것
    
- 예: 기존에 `employee_id`만 기본 키였는데, 합병 후 `subsidiary_id`까지 함께 기본 키로 설정해야 중복 방지
    

---

필요하다면:  
✅ 이런 상황에서 쓰는 SQL 예제,  
✅ primary key 설계 팁,  
✅ composite key 설명

좋아요! 이 문장도 요청하신 대로 분석해줄게요.

---

### 🌟 **전체 문장**

Thus the new primary key has two columns: the EMPLOYEE_ID as before and the SUBSIDIARY_ID to reestablish uniqueness.

---

### 🌍 **전체 해석**

따라서 새로운 기본 키는 두 개의 컬럼을 가진다: 예전처럼 EMPLOYEE_ID와, 고유성을 다시 확보하기 위한 SUBSIDIARY_ID.

---

### 🔍 **구문/단어 해석**

- **thus** → 따라서, 그러므로
    
- **new primary key** → 새로운 기본 키
    
- **has two columns** → 두 개의 컬럼을 가진다
    
- 🔴****EMPLOYEE_ID as before** → 예전처럼 EMPLOYEE_ID
    
- **SUBSIDIARY_ID to reestablish uniqueness** → 고유성을 다시 확보하기 위한 SUBSIDIARY_ID
    

---

### 🌳 **문장 구조 (한국어로 트리 형태)**

- [주절]  
    → The new primary key has two columns (새로운 기본 키는 두 개의 컬럼을 가진다)
    
- [컬럼 1]  
    → the EMPLOYEE_ID as before (예전처럼 EMPLOYEE_ID)
    
- [컬럼 2]  
    → and the SUBSIDIARY_ID to reestablish uniqueness (고유성을 다시 확보하기 위한 SUBSIDIARY_ID)
    

---

### 💬 **정리해서 한국어로 자연스럽게**

따라서 새로운 기본 키는 두 개의 컬럼으로 구성된다: 예전처럼 EMPLOYEE_ID, 그리고 고유성을 다시 확보하기 위한 SUBSIDIARY_ID.

---

📌 **보충 설명 (혹시 궁금할까 봐!)**

- **왜 SUBSIDIARY_ID가 필요할까?**  
    합병 후 여러 자회사에 같은 EMPLOYEE_ID가 존재할 수 있으므로, 고유성을 보장하려면 `(SUBSIDIARY_ID, EMPLOYEE_ID)` 조합으로 primary key를 잡아야 함.
    

---

필요하다면:  
✅ 이 문장 기반 SQL 예제,  
✅ composite primary key 개념 정리,  
✅ 관련 실전 질문 모음

좋아요! 요청하신 문장을 아래처럼 분석해드릴게요.

---

### 🌟 **전체 문장**

A query for a particular employee has to take the full primary key into account — that is, the SUBSIDIARY_ID column also has to be used.

---

### 🌍 **전체 해석**

특정 직원에 대한 쿼리는 전체 기본 키를 고려해야 한다 — 즉, SUBSIDIARY_ID 컬럼도 사용되어야 한다.

---

### 🔍 **구문/단어 해석**

- 🔴**A query for a particular employee** → 특정 직원에 대한 쿼리
    
-🔴 **has to take ~ into account** → ~를 고려해야 한다, ~를 감안해야 한다
    
- **the full primary key** → 전체 기본 키
    
- **that is** → 즉, 다시 말해
    
- **SUBSIDIARY_ID column** → SUBSIDIARY_ID 컬럼
    
- 🔴**has to be used** → 사용되어야 한다
    

---

### 🌳 **문장 구조 (한국어로 트리 형태)**

- [주절]  
    → A query for a particular employee has to take the full primary key into account  
     (특정 직원에 대한 쿼리는 전체 기본 키를 고려해야 한다)
    
- [부연 설명 (that is)]  
    → the SUBSIDIARY_ID column also has to be used  
     (즉, SUBSIDIARY_ID 컬럼도 사용되어야 한다)
    

---

### 💬 **정리해서 한국어로 자연스럽게**

특정 직원에 대한 쿼리는 전체 기본 키를 고려해야 한다 — 즉, SUBSIDIARY_ID 컬럼도 함께 사용해야 한다.

---

📌 **보충 설명 (혹시 궁금할까 봐!)**

- **왜 SUBSIDIARY_ID까지 써야 하나?**  
    합병 후 각 자회사마다 EMPLOYEE_ID가 중복될 수 있기 때문에, 고유 식별을 위해 `(SUBSIDIARY_ID, EMPLOYEE_ID)` 전체를 WHERE 조건 등에 써야 함.
    

예:

```sql
SELECT * FROM EMPLOYEES
WHERE SUBSIDIARY_ID = 'S01' AND EMPLOYEE_ID = '12345';
```

---
### 전체 문장

what happens when using only one of the key columns, for example, when searching all employees of a subsidiary?

---

#### 전체 해석

키 컬럼 중 하나만 사용할 때 어떤 일이 일어나는가? 예를 들어, 한 자회사의 모든 직원들을 검색할 때처럼.

---

#### 구문, 단어 해석 및 문장 구조 트리

- **what happens**
    
    - 무엇이 일어나는가
        
    - (what: 무엇 / happens: 일어나다)
        
- **when using only one of the key columns**
    
    - 키 컬럼 중 하나만 사용할 때
        
    - (when: ~할 때 / using: 사용하는 것 / only one: 오직 하나 / of the key columns: 주요 컬럼들 중에서)
        
- **for example**
    
    - 예를 들어
        
- **when searching all employees of a🔴 subsidiary** 자회사
    
    - 한 자회사의 모든 직원들을 검색할 때
        
    - (when: ~할 때 / searching: 검색하는 것 / all employees: 모든 직원들 / of a subsidiary: 한 자회사(의))
        

---

#### 문장 구조 트리

- [what happens]  
     - [when (using only one of the key columns)]  
       - [for example,]  
        - [when (searching all employees of a subsidiary)]
    

---

### 전체 해석 다시

> **키 컬럼 중 하나만 사용할 때(예: 한 자회사의 모든 직원을 검색할 때)는 어떤 일이 발생할까?**

필요하면 더 세분화해서 단어/구문 설명도 추가해줄 수 있어요!

### 전체 문장

if the table grows tenfold, the FULL TABLE SCAN takes ten times as long.

---

#### 전체 해석

만약 테이블이 10배로 커지면, 전체 테이블 스캔은 10배 더 오래 걸린다.

---

#### 구문, 단어 해석 및 문장 구조 트리

- 🔴**if the table grows tenfold**
    
    - 만약 테이블이 10배로 커지면
        
    - (if: 만약 / the table: 테이블이 / grows: 커지다, 증가하다 / tenfold: 10배로)
        
- **the FULL TABLE SCAN takes ten times as long**
    
    - 전체 테이블 스캔은 10배 더 오래 걸린다
        
    - (the FULL TABLE SCAN: 전체 테이블 스캔 / takes: 걸린다 / ten times as long: 10배만큼 오래)
        

---

#### 문장 구조 트리

- [if (the table grows tenfold)]  
     - [the FULL TABLE SCAN takes ten times as long]
    

---

### 전체 해석 다시

> **테이블이 10배로 커지면, 전체 테이블 스캔은 10배 더 오래 걸린다.**

### 전체 문장

This is mostly  
because an index lookup reads one block after the other as the  
database does not know which block to read next until the current  
block has been processed.

---

#### 전체 해석

이것은 주로 인덱스 조회가 한 블록씩 차례로 읽기 때문인데,  
데이터베이스는 현재 블록이 처리될 때까지 다음에 어떤 블록을 읽어야 할지 알지 못하기 때문이다.

---

#### 구문, 단어 해석 및 문장 구조 트리

- **This is mostly because**
    
    - 이것은 주로 ~ 때문이다
        
    - (this: 이것은 / is mostly: 주로 ~이다 / because: ~때문에)
        
- **an index lookup reads one block after the other**
    
    - 인덱스 조회가 한 블록씩 차례로 읽는다
        
    - (an index lookup: 인덱스 조회 / reads: 읽는다 / 🔴one block after the other: 한 블록씩 순서대로)
        
- **as the database does not know which block to read next until the current block has been processed**
    
    - 왜냐하면 데이터베이스가 현재 블록이 처리되기 전까지는  
        다음에 어떤 블록을 읽어야 할지 알지 못하기 때문이다
        
    - (as: ~이기 때문에 / the database: 데이터베이스는 / does not know: 알지 못한다 / which block to read next: 어떤 블록을 다음에 읽어야 할지 / until: ~할 때까지 / the current block has been processed: 현재 블록이 처리될 때까지)
        

---

#### 문장 구조 트리

- [This is mostly because]  
     - [an index lookup reads one block after the other]  
      - [as (the database does not know which block to read next until the current block has been processed)]
    

---

### 전체 해석 다시

> **이것은 주로 인덱스 조회가 한 블록씩 차례로 읽기 때문인데,  
> 데이터베이스는 현재 블록이 처리될 때까지 다음에 어떤 블록을 읽어야 할지 알지 못하기 때문이다.**

### 전체 문장

A FULL TABLE SCAN must get the entire table anyway so that the database can read larger chunks at a time (multi block read).

---

#### 전체 해석

전체 테이블 스캔(FULL TABLE SCAN)은 어차피 전체 테이블을 읽어야 하므로,  
데이터베이스가 한 번에 더 큰 덩어리(여러 블록)를 읽을 수 있다(멀티 블록 읽기).

---

#### 구문, 단어 해석 및 문장 구조 트리

- **A FULL TABLE SCAN must get the entire table anyway**
    
    - 전체 테이블 스캔은 어차피 전체 테이블을 읽어야 한다
        
    - (A FULL TABLE SCAN: 전체 테이블 스캔 / must get: 반드시 읽어야 한다 / the entire table: 전체 테이블 / anyway: 어차피)
        
- **so that the database can read larger chunks at a time (multi block read)**
    
    - 그래서 데이터베이스가 한 번에 더 큰 덩어리(여러 블록)를 읽을 수 있다
        
    - (so that: ~할 수 있도록 / the database can read: 데이터베이스가 읽을 수 있다 / larger chunks: 더 큰 덩어리 / 🔴at a time: 한 번에 / (multi block read): (여러 블록 읽기))
        

---

#### 문장 구조 트리

- [A FULL TABLE SCAN must get the entire table anyway]  
     - [so that (the database can read larger chunks at a time (multi block read))]
    

---

### 전체 해석 다시

> **전체 테이블 스캔은 어차피 전체 테이블을 읽어야 하므로, 데이터베이스가 한 번에 더 큰 덩어리(여러 블록)를 읽을 수 있다(멀티 블록 읽기).**

### 전체 문장

Although the database reads more data, it might need to execute fewer read operations.

---

#### 전체 해석

데이터베이스가 더 많은 데이터를 읽더라도, 실제로는 읽기 작업을 더 적게 수행해야 할 수도 있다.

---

#### 구문, 단어 해석 및 문장 구조 트리

- **Although the database reads more data**
    
    - 데이터베이스가 더 많은 데이터를 읽더라도
        
    - (Although: ~일지라도 / the database: 데이터베이스가 / reads: 읽다 / more data: 더 많은 데이터)
        
- **it might need to execute fewer read operations**
    
    - 더 적은 읽기 작업을 수행해야 할 수도 있다
        
    - (it: 데이터베이스가 / might need to: ~할 필요가 있을 수도 있다 / execute: 실행하다, 수행하다 / 🔴fewer read operations: 더 적은 읽기 작업)
        

---

#### 문장 구조 트리

- [Although (the database reads more data)]  
     - [it might need to execute fewer read operations]
    

---

### 전체 해석 다시

> **데이터베이스가 더 많은 데이터를 읽더라도, 실제로는 읽기 작업(연산)을 더 적게 해야 할 수도 있다.**

더 궁금한 부분 있으면 바로 말씀해 주세요!