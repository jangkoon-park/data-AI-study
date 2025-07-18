### 전체 문장

The database does not use the index because it cannot use single columns from a concatenated index arbitrarily. A closer look at the index structure makes this clear.

---

#### 전체 해석

데이터베이스는 인덱스를 사용하지 않는다. 왜냐하면 결합 인덱스에서 단일 컬럼을 임의로 사용할 수 없기 때문이다. 인덱스 구조를 좀 더 자세히 살펴보면 이 점이 명확해진다.

---

#### 구문/단어 해석

- database: 데이터베이스
    
- does not use: 사용하지 않는다
    
- the index: 그 인덱스
    
- because: 왜냐하면
    
- it cannot use: 그것(데이터베이스)은 사용할 수 없다
    
- single columns: 단일 컬럼들
    
- 🔴from a concatenated index: 결합(복합) 인덱스에서
    
- 🔴 arbitrarily: 임의로
    
- 🔴a closer look at ~: ~를 좀 더 자세히 살펴보면
    
- index structure: 인덱스 구조
    
- 🔴makes this clear: 이것을 명확하게 해준다
    

---

#### 문장 구조 트리 (한국어 설명)

- [주어] The database
    
    - [동사] does not use
        
        - [목적어] the index
            
        - [이유] because
            
            - [주어] it
                
            - [조동사+동사] cannot use
                
                - [목적어] single columns
                    
                - [전치사구] from a concatenated index
                    
                - [부사] arbitrarily
                    
- [주어] A closer look at the index structure
    
    - [동사] makes
        
        - [목적어] this
            
        - [보어] clear
            

---

#### 트리 형태(한국어)

1. 데이터베이스(주어)  
    └─ 인덱스를 사용하지 않는다(동사+목적어)  
      └─ 왜냐하면(이유)  
        ├─ 결합 인덱스에서 단일 컬럼을  
        └─ 임의로 사용할 수 없기 때문이다
    
2. 인덱스 구조를 자세히 보면(주어+부사어)  
    └─ 이것이 명확해진다(동사+목적어+보어)
    

---

**추가로 해석이 더 필요한 부분, 또는 더 복잡한 문장도 요청해 주세요!**

### 전체 문장

that would be like searching a telephone directory by first name.

---

#### 전체 해석

그것은 마치 전화번호부를 이름(이름만)으로 찾아보는 것과 같다.

---

#### 구문/단어 해석

- that: 그것(앞에서 언급한 상황)
    
- 🔴would be like: ~와 같다, ~와 비슷하다
    
- searching: 찾는 것
    
- telephone directory: 전화번호부
    
- by first name: 이름(성 말고 이름) 기준으로
    

---

#### 문장 구조 트리 (한국어 설명)

- 그것(주어)  
    └─ 이름으로 전화번호부를 검색하는 것과 같다(동사+보어)
    

---

#### 의역 및 추가 설명

- 예를 들어,  
    전화번호부가 [성 → 이름] 순으로 정렬돼 있다면  
    “이름만으로” 원하는 사람을 바로 찾는 건 매우 비효율적이죠.
    
- 결합 인덱스도 첫 컬럼부터 정렬되어 있으므로,  
    **중간 컬럼만으로 찾으려 하면 이런 식으로 ‘느리다/비효율적이다’**는 비유입니다.
    

---

### 전체 문장

The index excerpt in Figure 2.1 shows that the entries for subsidiary 20 are not stored next to each other. It is also apparent that there are no entries with SUBSIDIARY_ID = 20 in the tree, although they exist in the leaf nodes. The tree is therefore useless for this query.

---

#### 전체 해석

그림 2.1의 인덱스 발췌 부분을 보면, 자회사 20에 대한 항목들이 서로 인접하게 저장되어 있지 않다는 것을 알 수 있다.  
또한, 트리(인덱스의 상위 구조)에는 SUBSIDIARY_ID가 20인 항목이 전혀 없는 것이 분명하다.  
(비록 리프 노드에는 존재하지만)  
따라서 이 트리(인덱스 구조)는 이 쿼리에는 쓸모가 없다.

---

#### 구문/단어 해석

- index excerpt: 인덱스 발췌(일부 보여주는 그림)
    
- entries for subsidiary 20: 자회사 20에 대한 항목들
    
- not stored next to 🔴each other: 서로 인접해서 저장되어 있지 않다
    
- apparent: 분명하다
    
- there are no entries with SUBSIDIARY_ID = 20: SUBSIDIARY_ID가 20인 항목이 없다
    
- in the tree: (인덱스의) 트리 구조 내에서는
    
- although they exist in the leaf nodes: 리프 노드(트리의 맨 마지막 데이터 노드)에는 있지만
    
- useless for this query: 이 쿼리에는 쓸모가 없다
    

---

#### 문장 구조 트리 (한국어 설명)

1. 인덱스 발췌(주어)  
    └─ 자회사 20의 항목들이 서로 인접해 있지 않음을 보여준다(동사+목적어)
    
2. 또한 (접속사)  
    └─ 트리에는 SUBSIDIARY_ID = 20인 항목이 없다는 것이 분명하다(동사+목적어)  
    └─ 비록 리프 노드에는 존재하지만(부사절)
    
3. 따라서 이 트리는 이 쿼리에 쓸모가 없다(원인-결과)
    

---

#### 추가 설명

- 인덱스 트리(예: B-트리)에서  
    **찾고 싶은 값(예: SUBSIDIARY_ID = 20)이  
    트리의 주요 경로(브랜치)에 없고,  
    리프 노드에만 흩어져 있을 수 있다**는 뜻입니다.
    
- 이 경우  
    → 트리(인덱스)의 빠른 검색 구조를 전혀 활용하지 못함  
    → 결국 전체를 다 훑어야 하니 “인덱스가 쓸모가 없다”는 의미입니다.
    

---

### 전체 문장

🔴There is however a better solution

---
#### 전체 해석
하지만 더 나은 해결책이 있습니다.

---

#### 구문 및 단어 해석

- There is: ~이 있다, 존재한다
    
- however: 그러나, 하지만 (문장 중간에 쓰여 강조)
    
- a better solution: 더 나은 해결책
    

---

### 전체 문장

The trick is to reverse the index column order so that the SUBSIDIARY_ID is in the first position:

---

#### 전체 해석

요령은 인덱스 컬럼의 순서를 뒤집어서 SUBSIDIARY_ID가 첫 번째 위치에 오도록 하는 것입니다.

---

#### 구문 및 단어 해석

- 🔴The trick is to ~ : 요령/비결은 ~하는 것이다
    
- reverse : 뒤집다, 반대로 하다
    
- the index column order : 인덱스 컬럼(열) 순서
    
- 🔴so that ~ : ~가 되도록, ~하기 위해
    
- 🔴the SUBSIDIARY_ID is in the first position : SUBSIDIARY_ID가 첫 번째 위치에 있다
    

---

더### 전체 문장

The SUBSIDIARY_ID has become the primary sort criterion.

---

#### 전체 해석

SUBSIDIARY_ID가 기본 정렬 기준이 되었습니다.

---

#### 구문 및 단어 해석

- The SUBSIDIARY_ID: SUBSIDIARY_ID(컬럼)
    
- has become: ~가 되었다
    
- 🔴the primary sort criterion: 주된(기본) 정렬 기준
    

---

