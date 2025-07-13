
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