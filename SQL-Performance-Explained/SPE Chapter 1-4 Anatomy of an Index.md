### 전체 문장

**This contradiction has fueled the myth of the “degenerated index” for a long time**

---

### 구문 분석 및 해석

#### 1. **This contradiction**

- **주어 (S)**
    
- 의미: **이 모순**
    
- 앞 문장에서 언급된 모순된 내용 전체를 지칭
    

#### 2. 🔴**has fueled**

- **동사 (V)** - 현재완료 시제
    
- 의미: **불을 붙여왔다 / 부추겨왔다 / 조장해왔다**
    
- `fuel`은 원래 "연료를 공급하다"이지만, 비유적으로 "어떤 생각, 감정을 부추기다"라는 의미
    

#### 3. 🔴**the myth of the “degenerated index”**

- **목적어 (O)**
    
- 의미: **‘퇴화된 인덱스’라는 신화**
    
- `myth`는 여기서 **사실이 아니지만 널리 믿어지는 이야기**라는 의미
    
- `"degenerated index"`는 **성능이 떨어진 인덱스**에 대한 오해 또는 부정적인 고정관념을 의미
    

#### 4. **for a long time**

- **부사구**
    
- 의미: **오랫동안**
    
- 전체 문장에 대한 시간 정보 제공
    

---

### 문장 구조 트리 (한국어 설명)

```
[전체 문장]
└─ [주어] This contradiction
   └─ [동사] has fueled
      └─ [목적어] the myth
         └─ [전치사구] of the “degenerated index”
   └─ [부사구] for a long time
```

---

### 전체 해석

> **이 모순은 ‘퇴화된 인덱스’라는 신화를 오랫동안 부추겨왔다.**

또는 좀 더 자연스럽게:

> **이 모순은 ‘성능이 저하된 인덱스’라는 잘못된 믿음을 오랫동안 조장해왔다.**

---

### 전체 문장

**The myth proclaims an index rebuild as the miracle solution**

---

### 구문 분석 및 해석

#### 1. **The myth**

- **주어 (S)**
    
- 의미: **그 신화**
    
- 앞 문장에서 언급된 `"degenerated index"`에 대한 **오해/잘못된 믿음**을 가리킴
    

#### 2. 🔴**proclaims**

- **동사 (V)**
    
- 의미: **선언한다 / 주장한다 / 떠든다**
    
- `proclaim`은 공공연하게 말하거나 강하게 주장하는 뜻
    

#### 3. 🔴**an index rebuild**

- **직접목적어 (O1)**
    
- 의미: **인덱스 재구축**
    
- DB에서 `index rebuild`는 인덱스를 다시 만드는 작업, 종종 성능 향상을 위해 사용됨
    

#### 4. **as the miracle solution**

- **보어 역할을 하는 전치사구 (O2 또는 보어)**
    
- 의미: **기적 같은 해결책으로서**
    
- `as`는 **~로서**의 의미로, index rebuild가 miracle solution 역할을 한다고 주장함
    

---

### 문장 구조 트리 (한국어 설명)

```
[전체 문장]
└─ [주어] The myth
   └─ [동사] proclaims
      └─ [목적어] an index rebuild
         └─ [보어/전치사구] as the miracle solution
```

---

### 전체 해석

> **그 신화는 인덱스 재구축을 기적의 해결책으로 주장한다.**

또는 더 자연스럽게:

> **그 잘못된 믿음은 인덱스를 재구축하는 것이 기적 같은 해결책이라고 여긴다.**

---

**전체 문장**  
The real reason trivial statements can be slow—even when using an index—can be explained on the basis of the previous sections.

---

**구문 및 단어 해석**

- **The real reason**: 진짜 이유
    
- 🔴**trivial statements**: 사소한 SQL 문장들
    
    - _trivial_: 사소한, 중요하지 않은
        
    - _statements_: 여기서는 SQL 문장을 뜻함
        
- **can be slow**: 느릴 수 있다
    
- **even when using an index**: 인덱스를 사용하더라도
    
    - _even when_: ~할 때조차
        
    - _using an index_: 인덱스를 사용하는 것
        
- **can be explained**: 설명될 수 있다
    
- **on the basis of**: ~을 근거로, ~에 기반하여
    
- **the previous sections**: 이전 절들, 앞에서 설명한 부분들
    

---

**문장 구조 (트리 형태)**

```
[주어]
The real reason
    └─ [관계절] 🔴that 생략됨
       trivial statements can be slow
           └─ [부사절]
              even when using an index

[동사]
can be explained

[부사구]
on the basis of the previous sections
```

---

**전체 해석**  
사소한 SQL 문장들이 인덱스를 사용하더라도 느릴 수 있는 진짜 이유는 앞에서 설명한 절들에 기반하여 설명될 수 있다.


**전체 문장**  
The first ingredient for a slow index lookup is the leaf node chain.

---

**단어 및 구문 해석**  
🔴The first ingredient : 첫 번째 요소  
for a slow index lookup : 느린 인덱스 조회를 위한  
is : ~이다 (주어와 보어 연결)  
the leaf node chain : 리프 노드 체인 (B-트리 구조의 가장 하위 노드들이 연결된 구조)

---

**문장 구조 (트리 형태)**

- [The first ingredient] → 주어
    
    - [for a slow index lookup] → 형용사구, 주어 'ingredient' 수식
        
- [is] → 동사 (주어와 보어 연결)
    
- [the leaf node chain] → 보어 (주어의 정체를 설명)
    

---

**전체 해석**  
느린 인덱스 조회의 첫 번째 원인은 리프 노드 체인이다.

**전체 문장**  
Consider the search for “57” in Figure 1.3 again.

---

**단어 및 구문 해석**

- 🔴**Consider** : 고려해봐라, 다시 살펴봐라 (명령문, 동사)
    
- **the search** : 그 탐색, 검색
    
- **for “57”** : “57”을 찾는
    
- **in Figure 1.3** : 그림 1.3에서
    
- **again** : 다시 한 번
    

---

**문장 구조 (트리 형태)**

- [Consider] → 동사 (명령문 주어 생략: 너는 ~을 고려해라)
    
- [the search] → 목적어
    
    - [for “57”] → 형용사구, 'search'를 수식
        
    - [in Figure 1.3] → 형용사구, 'search'를 수식
        
- [again] → 문장 전체를 수식하는 부사
    

---

**전체 해석**  
그림 1.3에서 “57”을 찾는 과정을 다시 한번 살펴보자.

**전체 문장**  
At least two entries are the same, to be more precise.

---

**단어 및 구문 해석**  
At least: 적어도  
two entries: 두 개의 항목  
are: ~이다 (be 동사, 현재 시제)  
the same: 동일한, 같은  
to be more precise: 더 정확히 말하자면

---

**문장 구조 (트리 형태)**  
[At least two entries] → 주어  
[are] → 동사  
[the same] → 보어  
[🔴to be more precise] → 부사적 표현 (문장 전체를 수식함, 추가 설명)

---

**전체 해석**  
좀 더 정확히 말하자면, 적어도 두 개의 항목은 동일하다.




**전체 문장**  
the next leaf node could have further entries for “57”.

---

**단어 및 구문 해석**

- **the next leaf node**: 다음 리프 노드
    
- **could have**: ~을 가질 수 있다 (가능성을 나타내는 조동사)
    
- 🔴**further entries**: 추가적인 항목들
    
- **for “57”**: “57”에 해당하는
    

---

**문장 구조 (트리 형태, 한국어로)**  
[the next leaf node] → **주어**  
[could have] → **조동사 + 동사**  
[further entries] → **목적어**  
[for “57”] → **entries를 수식하는 전치사구** ("57"에 해당하는)

---

**전체 해석**  
다음 리프 노드는 “57”에 해당하는 추가 항목들을 가지고 있을 수도 있다.


**전체 문장**  
The database must read the next leaf node to see if there are any more matching entries.

**전체 해석**  
더 많은 일치 항목이 있는지 확인하기 위해, 데이터베이스는 다음 리프 노드를 반드시 읽어야 한다.

---

**단어 및 구문 해석**  
The database: 데이터베이스는  
must: 반드시 ~해야 한다 (조동사)  
read: 읽다  
the next leaf node: 다음 리프 노드  
🔴to see if ~: ~인지 확인하기 위해  
there are: ~이 있다  
any more matching entries: 더 많은 일치하는 항목들

---

**문장 구조 (한국어 트리 형태)**  
[The database] → 주어  
[must read] → 조동사 + 동사  
[the next leaf node] → 목적어  
[to see if there are any more matching entries] → 부사적 목적구 (확인하기 위해)

- [to see if] → ~인지 보기 위해
    
    - [there are] → 종속절의 동사
        
    - [any more matching entries] → 종속절의 주어 (일치하는 항목들)



**전체 문장**  
Even a single leaf node might contain many hits—often hundreds.

**전체 해석**  
단 하나의 리프 노드조차도 많은 일치 항목을 포함할 수 있으며, 종종 그 수는 수백 개에 이른다.

---

**단어 및 구문 해석**  
Even: ~조차도, 심지어  
a single leaf node: 단 하나의 리프 노드  
🔴might contain: 포함할 수 있다 (가능성 조동사)  
many hits: 많은 히트 (일치 항목, 검색 결과)  
often: 종종  
hundreds: 수백 개

---

**문장 구조 (한국어 트리 형태)**  
[Even a single leaf node] → 주어  
[might contain] → 조동사 + 동사  
[many hits] → 목적어  
[—often hundreds] → 삽입 표현 (many hits를 설명: 종종 수백 개)


**전체 문장**  
An index lookup requires three steps: (1) the tree traversal; (2) following the leaf node chain; (3) fetching the table data.  
**전체 해석**  
인덱스 조회는 세 단계가 필요하다: (1) 트리 탐색, (2) 리프 노드 체인 따라가기, (3) 테이블 데이터 가져오기.

---

**단어 및 구문 해석**  
An index lookup: 인덱스 조회  
requires: 필요로 한다  
three steps: 세 단계  
(1) the tree traversal: 트리 탐색  
(2)🔴following the leaf node chain: 리프 노드 체인을 따라가기  
(3)🔴 fetching the table data: 테이블 데이터를 가져오기

---

**문장 구조 (한국어 트리 형태)**  
[An index lookup] → 주어  
[requires] → 동사  
[three steps] → 목적어  
[(1) the tree traversal] → 첫 번째 단계  
[(2) following the leaf node chain] → 두 번째 단계  
[(3) fetching the table data] → 세 번째 단계

---

**전체 해석 (반복)**  
인덱스 조회는 세 단계가 필요하다: (1) 트리 탐색, (2) 리프 노드 체인 따라가기, (3) 테이블 데이터 가져오기.

**전체 문장**  
The tree traversal is the only step that has an upper bound for the number of accessed blocks—the index depth.  
**전체 해석**  
트리 탐색만이 접근되는 블록 수에 대해 상한선을 가지는 유일한 단계이다 — 그 상한은 인덱스의 깊이이다.

---

**단어 및 구문 해석**  
The tree traversal: 트리 탐색  
is: ~이다  
the only step: 유일한 단계  
🔴that has an upper bound: 상한선을 가지는  
for the number of accessed blocks: 접근된 블록의 수에 대한  
the index depth: 인덱스 깊이 (→ 상한선의 기준이 되는 값)

---

**문장 구조 (한국어 트리 형태)**  
[The tree traversal] → 주어  
[is] → 동사  
[the only step] → 보어  
  [that has an upper bound] → 관계절 (step을 수식)  
    [for the number of accessed blocks] → 전치사구 (upper bound를 수식)  
[—the index depth] → 삽입 구 (upper bound가 무엇인지 설명)

---

**전체 해석 (다시)**  
트리 탐색은 접근되는 블록 수에 상한이 존재하는 **유일한 단계**이며, 그 상한은 **인덱스의 깊이**이다.