# 머신러닝 학습 정리

실습은 `MACHINELEARNING/00`(Docker + Jupyter 환경) → `실습코드/01_BASIC`(파이썬 기초) → `실습코드/02_NUMPY_PANDAS`(Numpy) 순서로 진행.
`00/docker-compose.yml`로 `jupyter/scipy-notebook` 컨테이너를 띄우고(`requirements.txt`를 `/tmp`에 마운트해 `pip install` 후 실행), `../실습코드`를 작업 폴더로 마운트해서 실습.

---

## 01_BASIC — 파이썬 기초 (`01.ipynb`)

ML 코드에서 바로 쓰이는 문법 위주로 훑는 개론.

| 주제 | 핵심 |
|---|---|
| 변수·자료형 | `int`/`float`/`str`/`bool`, `type()`으로 확인 |
| f-string | `f'{name}님의 점수는 {score}점'`, 뒤에서 서식(`:.4f`, `:.1%`) 확장 |
| 리스트 | 인덱싱(`[0]`,`[-1]`)·슬라이싱(`[0:3]`)·`append`·`len` |
| 딕셔너리 | `d['키']`, `.keys()`/`.values()`, 키 추가는 `d['새키']=값` |
| 조건문/반복문 | `if/elif/else`, `for x in list`, `for i in range(n)`, `while` |
| 함수 | 기본값 인자(`age=20`), 다중 반환(`return a,b` → 튜플, 언패킹) |
| 컴프리헨션 | `[s for s in scores if s>=80]`(필터), `[s*2 for s in scores]`(변환) |
| 연산자 | `//`(몫) `%`(나머지) `**`(거듭제곱), `in`(멤버십), `and/or/not` |
| 튜플 | 수정 불가, 함수 다중 반환의 실체. `x, y = point` 언패킹 |
| 딕셔너리 안전 접근 | `d.get('key')`→없으면 `None`, `d.get('key', 기본값)` |
| import 3방식 | `import math`(통째로), `from statistics import mean`(콕 집어서), 실전에서는 `import pandas as pd` 형태(별칭) |
| dict 순회/enumerate/zip | `for k,v in d.items()`, `enumerate(list)`, `zip(a,b)` — 전처리·평가 반복에서 자주 사용 |
| sorted+lambda | `sorted(pairs, key=lambda x: x[1], reverse=True)` — 특성 중요도 정렬에 그대로 쓰이는 패턴 |

> `RandomForestClassifier(random_state=0)`, `test_size=0.2`처럼 sklearn 함수 호출에 등장하는 **기본값 인자**, `train_test_split(...)`의 **다중 반환/언패킹**이 여기 문법 그대로 이어진다는 점을 코드 주석으로 계속 짚어둠.

---

## 01_BASIC — 연습문제 (`01_ex.ipynb`, `02_ex.ipynb`)

TODO 셀 → `assert` 채점 셀 → 접이식 정답/해설 순서로 구성된 자기 채점형 연습 노트북. 정답은 모두 작성·통과 완료.

### `01_ex.ipynb` — 파이썬 기초 문법 심화 10선

| # | 주제 | 핵심 함정 |
|---|---|---|
| 1 | 안전한 형변환 | `None.isdigit()` → `AttributeError`, `'3.5'.isdigit()`는 `False`(점 때문에) → `.replace('.', '', 1).isdigit()`로 우회 |
| 2 | f-string 정렬 성적표 | `{x:<8}`(왼쪽) `{x:>5}`(오른쪽) `{x:.1f}%` 포맷 스펙 조합 |
| 3 | 슬라이싱 + 얕은 복사 함정 | `data[::-1]`(역순) `data[::-3]`(역방향 스텝); `a = data`는 같은 객체 별칭, `b = data[:]`가 진짜 복사 |
| 4 | 딕셔너리 빈도수 세기 | `d[w] = d.get(w, 0) + 1` 카운팅 관용구, `sorted(d.items(), key=lambda x: x[1], reverse=True)` |
| 5 | 조건문 복합 논리 | 조건 **순서 = 우선순위**(출석미달을 최상단에 둬야 점수 100점도 F), 윤년 판정(`%4==0 and %100!=0` or `%400==0`) |
| 6 | while — 콜라츠 추측 | `n = n // 2` (정수 나눗셈, `/` 쓰면 float로 새서 타입 지저분해짐), while은 조건을 바꾸는 줄이 없으면 무한루프 |
| 7 | 함수 — 가변인자·다중반환 | `*nums`로 개수 제한 없이 받아 튜플로 처리, `return (a,b,c,d)` |
| 8 | 컴프리헨션 심화 | `if`의 위치 차이: **for 뒤 if**=필터(`[x for x in L if x>0]`), **for 앞 if/else**=변환(`['+' if x>0 else '-' for x in L]`); 중첩 for는 바깥→안쪽 순서 그대로 |
| 9 | 소수 판별 + zip | `while i*i <= n`으로 제곱근까지만 검사, `zip(primes, primes[1:])`로 이웃 쌍(쌍둥이 소수) 생성 |
| 10 | 종합 — 학생 데이터 분석 | 결측(`None`) 점수·키 오타 행을 `r.get('이름') is not None`으로 필터링; **결측을 0으로 채우면 평균이 완전히 달라짐**(실전 결측치 처리의 중요성 예고) → 판다스면 `groupby().mean()` 3줄로 대체 가능 |

### `02_ex.ipynb` — ML 필수 파이썬 패턴 10선

01_ex보다 sklearn/pandas 실전 패턴에 더 밀착된 문제들.

| # | 주제 | 핵심 함정 / ML 연결 |
|---|---|---|
| 1 | import 3가지 방식 | `stdev`(표본, n-1) vs `pstdev`(모집단, n) — numpy `np.std()` 기본은 모표준편차, pandas `Series.std()` 기본은 표본표준편차라 **같은 데이터도 값이 다르게 나오는 유명한 함정**; z-score 정규화 = `StandardScaler`가 하는 일 |
| 2 | 키워드 전용 인자·`**kwargs` | `def f(name, *, n_estimators=100, **extra)` — `*` 뒤는 반드시 `이름=값`으로만(sklearn이 이렇게 설계됨); `**params`로 딕셔너리를 인자로 언패킹하는 게 하이퍼파라미터 튜닝의 핵심 문법 |
| 3 | `train_test_split` 직접 구현 | 반환 순서는 항상 `X_train, X_test, y_train, y_test` — 순서를 잘못 받으면 **에러 없이** 라벨/특성이 뒤바뀌는 조용한 버그; 셔플 없이 뒤 20%만 자르면 테스트셋에 한 클래스만 몰릴 수 있어 실제로는 `shuffle`+`stratify`+`random_state`가 필수 |
| 4 | 컬럼명 표준화(snake_case) | 문자열 메서드는 원본을 안 바꾸고 **새 문자열 반환**(`s = s.strip()`처럼 재대입 필요) vs 리스트의 `.sort()`/`.append()`는 원본을 직접 바꾸고 `None` 반환 — `nums = nums.sort()`가 흔한 실수 |
| 5 | CSV 파싱 + 결측 처리 | `casters = {'age': int, 'fare': float}`처럼 **함수를 딕셔너리 값으로 저장**해뒀다 꺼내 호출(`casters['age'](raw)`); `int('')`는 에러라 결측은 반드시 사전 검사 |
| 6 | 딕셔너리 병합/비교 | `result = default.copy(); result.update(custom)` (`.copy()` 없으면 원본 오염 → 재현 불가능한 실험의 흔한 원인); `diff()`는 `set(a) | set(b)`로 두 설정의 키 합집합을 순회 |
| 7 | 혼동행렬 직접 계산 | `zip(y_true, y_pred)`로 TP/FP/FN/TN 집계, `enumerate+zip`으로 틀린 인덱스 추출; 분모 0 방어(`if (TP+FP)>0 else 0.0`); 불균형 데이터에서는 accuracy가 무의미해 precision/recall/f1을 봐야 하는 이유 |
| 8 | 특성 중요도 정렬 | `key=lambda x: (-x[1], x[0])`로 **다중 키 정렬**(값 내림차순 + 이름 오름차순 동시에, `reverse=True`는 모든 키에 적용되므로 부호 반전이 정석); 누적 기여도 계산 시 "담고 나서 검사"와 "담기 전 검사"의 off-by-one 차이 |
| 9 | f-string 리포트 | `{x:.1%}`는 **이미 100을 곱함**(`acc*100`까지 곱하면 안 됨), `{x:,}` 천단위 콤마, `{x=}`로 변수명+값 동시 출력(디버깅용) |
| 10 | 미니 ML 파이프라인 종합 | `parse→impute→split→fit_baseline→evaluate` 5단계로 sklearn 흐름을 직접 구현. **`[r.copy() for r in rows]`**로 딕셔너리 각각을 복사해야 함(리스트만 복사하면 안의 딕셔너리는 공유되는 얕은 복사 함정); 베이스라인(최빈 클래스 찍기)보다 못하면 모델이 아무것도 학습 못 한 것; **결측 대치는 반드시 split 이후 train 통계로만 해야 데이터 누수(data leakage)를 피함** |

---

## 02_NUMPY_PANDAS — Numpy 기초 (`01_Numpy.ipynb`)

```python
import numpy as np
a = np.array([1, 2, 3, 4])
```

| 주제 | 코드 | 비고 |
|---|---|---|
| 배열 생성 | `np.array(list)`, `np.zeros(3)`, `np.ones(3)`, `np.arange(0,10,2)` | 리스트 → `ndarray` |
| 속성 | `a.shape`, `a.ndim`, `a.dtype` | `(4,)`처럼 튜플로 나오는 shape |
| 인덱싱/슬라이싱 | `a[0]`, `a[-1]`, `a[1:4]` | 파이썬 리스트와 동일한 문법 |
| 2차원 배열 | `m[0]`(행), `m[0,2]`(원소), `m[:, 1]`(열 전체) | `pred[:, 1]`처럼 예측확률 중 특정 클래스 열만 뽑을 때 그대로 쓰는 패턴 |
| 브로드캐스팅 | `a * 2`, `a + 10`, `a + a` | 반복문 없이 원소별 연산 |
| 불리언 인덱싱 | `a > 20` → `[False True ...]`, `a[a > 20]` | 조건에 맞는 값만 필터링 — pandas 조건 필터링의 기반 |
| 집계 + axis | `m.sum()`, `m.sum(axis=0)`(열별=세로), `m.sum(axis=1)`(행별=가로), `m.mean()/max()/std()` | axis 방향 헷갈리기 쉬움: 0=열 방향으로 합쳐 내려감, 1=행 방향으로 합쳐 옆으로 감 |
| reshape | `a.reshape(2,3)`, `a.reshape(-1,1)` | `-1`은 나머지 차원에 맞춰 자동 계산 (열벡터로 바꿀 때 자주 사용) |

---

## 03_PANDAS — DataFrame 기초 (`01.ipynb`, `02.ipynb`)

```python
import pandas as pd
menu = pd.Series(['비빔밥', '김치찌개', '된장찌개'])
df = pd.DataFrame({'메뉴': menu, '가격': price})
```

| 주제 | 코드 | 비고 |
|---|---|---|
| Series → DataFrame | `pd.DataFrame({'col': series, ...})`, `pd.DataFrame({'col': [list], ...})` | 딕셔너리 키가 열 이름 |
| 열 선택 | `df['가격']`→Series, `df[['가격']]`→DataFrame(대괄호 2개), `df[cols]` | `type()`으로 반환 타입이 갈리는 걸 직접 확인 |
| `loc` vs `iloc` | `df.loc[조건, [열이름,...]]`(라벨/조건 기반), `df.iloc[0:2, 0:2]`(정수 위치 기반) | `loc`은 슬라이싱 끝점 **포함**, `iloc`은 파이썬처럼 끝점 **미포함** — 같은 범위를 표현할 때 개수 차이 원인 |
| 열 추가/연산 | `df['할인가'] = (df['가격']*0.9).astype(int)` | 브로드캐스팅 그대로 새 열에 대입 |
| 조건부 값 수정 | `df.loc[df['메뉴']=='김치찌개', '가격'] = 9500` | `loc`으로 조건 필터링 + 값 대입을 한 줄에 |
| 열 삭제 | `df.drop(columns=['할인가'])` | 원본 불변, 재대입 필요(`df = df.drop(...)`) |
| 정렬 | `df.sort_values(by='가격', ascending=False)` | |
| 다중 조건 필터 | `df[(cond1) & (cond2)]` | `and`가 아닌 `&`, 각 조건은 괄호로 감싸야 함 |
| 열 이름 변경 | `df.rename(columns={'메뉴':'menu', ...})` | |
| CSV 입출력 | `df.to_csv('x.csv', index=False)`, `pd.read_csv('x.csv')` | `index=False` 안 붙이면 행번호가 열로 저장돼버림(제출 파일 기본 습관) |
| 탐색 기본기 | `df.shape`, `df.columns.tolist()`, `df.isnull().sum()`, `df.describe()`, `df.info()`, `df['col'].value_counts()` | 작업형1 단골: 결측치 개수·타겟 클래스 분포·수치열 요약을 한 세트로 확인 |
| 결측치 대치 | `s.fillna(s.median())`(수치), `s.fillna(s.mode()[0])`(범주) | 수치는 중앙값(이상치에 덜 민감), 범주는 최빈값이 기본 관용구 |
| 라벨 인코딩 | `series.map({'합격':1, '불합격':0})` | 이진 타겟을 0/1로 바꾸는 가장 단순한 방법 |
| 원핫 인코딩 | `pd.get_dummies(df)` | 문자열 열을 자동으로 찾아 0/1 열로 확장(열 개수가 급증할 수 있음 — 2780열까지 늘어난 예시로 확인) |
| 이어붙이기/그룹집계 | `pd.concat([a, b], axis=0)`(위아래), `df.groupby('열')['다른열'].mean()` | `concat`은 train+test를 합쳐 인코딩 기준을 통일할 때, `groupby`는 EDA·작업형1에서 그룹별 통계 낼 때 |

### 연습문제 (`ex/01.ipynb`) — cafe 데이터로 위 패턴 5문제 자기 채점

Series/DataFrame 반환 차이, `loc`/`iloc` 슬라이싱 끝점 차이, 조건부 값 수정, 다중조건+정렬, `groupby`→`drop`→`rename`→`to_csv`→재확인까지 한 사이클을 직접 구현. 모두 정답 작성·통과 완료.

---

## 04_MACHINE_LEARNING — Supervised_Learning · 이진분류 (`Binary_Classfication/01.ipynb`)

Adult Census 소득 데이터(`train.csv`/`test.csv`)로 소득이 `>50K`인지 이진분류하는 캐글류(빅데이터분석기사 작업형2 스타일) 엔드투엔드 파이프라인.

| 단계 | 코드 | 핵심 |
|---|---|---|
| 1. IMPORT | `train = pd.read_csv('train.csv')`, `test = pd.read_csv('test.csv')` | train 29304행×16열, test 3257행×15열(타겟 `income` 없음) |
| 2. EDA | `train.head()/tail()/sample(5)`, `train.describe()`, `train.info()`, 수치열 boxplot(`sns.boxplot`) | `age`에 `-38` 같은 이상치가 `describe()`의 `min`으로 바로 드러남 |
| 3. 결측치 처리 | 수치형(`age`, `hours.per.week`) → **train 중앙값**으로 `fillna`; 범주형(`workclass`, `occupation`, `native.country`) → **train 최빈값**으로 `fillna`; test도 반드시 **train에서 뽑은 값**으로 채움 | test 통계를 쓰면 데이터 누수 — train 기준 통계만 재사용하는 게 원칙 |
| 4. 타겟 분리 | `y = train['income'].map({'<=50K':0, '>50K':1})`; `train.drop(columns=['id','income'])`; `test_id = test['id']`로 제출용 id 보관 후 `test.drop(columns=['id'])` | `id`는 학습에 불필요한 식별자라 제거, 제출 시 다시 필요해 별도 보관 |
| 5. 인코딩 | `all_df = pd.concat([train, test], axis=0)` → `pd.get_dummies(all_df)` → `X = all_oh.iloc[:len(train)]`, `X_test = all_oh.iloc[len(train):]` | train/test를 **합쳐서** 원핫 인코딩해야 두 쪽의 더미 열 구성이 어긋나지 않음(따로 인코딩하면 카테고리 값 차이로 열 개수가 달라지는 흔한 실수) |
| 6. 검증셋 분리 | `train_test_split(X, y, test_size=0.2, random_state=0, stratify=y)` | `stratify=y`로 클래스 비율 유지(불균형 타겟 대응) |
| 7. 학습 | `RandomForestClassifier(n_estimators=100, random_state=0).fit(X_tr, y_tr)` | |
| 8. 평가 | `predict(X_val)`, `predict_proba(X_val)[:, 1]`(양성 클래스 확률만 2차원 슬라이싱), `accuracy_score`, `roc_auc_score`, `classification_report` | 정확도 0.8528, ROC-AUC 0.9014 — `income` 클래스가 불균형(1이 적음)이라 정확도만으론 부족, precision/recall/f1까지 같이 확인 |
| 9. 제출 파일 | `pd.DataFrame({'id': test_id, 'income': test_proba})`.`to_csv('submission.csv', index=False)` | 확률값(`predict_proba`)을 그대로 제출하는 ROC-AUC 채점 방식 예시 |

> `02_ex.ipynb` #3(`train_test_split` 반환 순서), #10(결측 대치는 split 이후 train 통계로만)에서 예고했던 원칙이 이 노트북에서 그대로 실전 코드로 이어짐.

---

## 04_MACHINE_LEARNING — Supervised_Learning · 다중분류 (`Multiclass_Classfication/ex/01.ipynb`, 미완성)

Credit Score 데이터(`train.csv` 10만행×28열 / `test.csv` 5만행×27열)로 고객 신용등급을 `Poor`/`Standard`/`Good` 3개 클래스로 분류하는 다중분류 파이프라인. 이진분류(`Binary_Classfication`)와 동일한 7단계 스켈레톤(문제정의→가져오기→EDA→전처리→분할·학습→검증→내보내기)을 재사용하되 타겟이 2클래스에서 3클래스로 확장된 버전. **05단계(라벨 매핑·원핫인코딩)까지만 작성돼 있고 06(모델 학습·검증지표)·07(모델/제출파일 내보내기) 셀은 비어 있어 아직 미완성.**

| 단계 | 코드 | 핵심 |
|---|---|---|
| 1. 문제정의 | 타겟 `Credit_Score` | `Poor`/`Standard`/`Good` 3개 클래스 — 이진분류의 `income`(`<=50K`/`>50K`)과 달리 다중분류 |
| 2. IMPORT | `pd.read_csv('train.csv')`/`test.csv'` | `Num_of_Delayed_Payment` 등 26번째 컬럼에서 `DtypeWarning`(혼합 타입) 발생 |
| 3. EDA | `head()`, `Credit_Score.unique()`, `describe()`, `info()`, `isnull().sum()` | `Age`에 `-500`, `Occupation`에 `_______` 같은 오염된 문자열이 그대로 들어있음(전처리 전 반드시 확인해야 할 이상치) |
| 4. 결측치 처리 | `cat_cols`/`num_cols`를 `dtype`+`isnull().any()` 조건의 리스트컴프리헨션으로 뽑아 train 중앙값/최빈값으로 `fillna` | **주의**: 실제 저장된 노트북은 셀 실행 순서(`execution_count`)가 1→44 뒤섞여 있어, 화면상 `cat_cols`/`num_cols` 결과가 빈 리스트(`[]`)로 찍혀 있음 — 위에서 아래로 새로 실행(Restart & Run All)하면 `Name`/`Type_of_Loan`/`Monthly_Balance` 등 실제 결측 컬럼이 잡히는지 재검증 필요 |
| 5. 라벨 인코딩 + 인코딩 | `y = train['Credit_Score'].map({'Poor':0,'Standard':1,'Good':2})`; `train.drop(columns=['ID','Customer_ID','Credit_Score'])`; `pd.concat([train,test])` 후 `pd.get_dummies` → `X`/`X_test` 분리 | 이진분류와 동일하게 train+test를 합쳐서 원핫 인코딩(더미 컬럼 어긋남 방지) |
| 6. 학습·검증 | *(미작성)* | `train_test_split(..., stratify=y)` → `RandomForestClassifier` → `accuracy_score`/`classification_report`가 다음 순서로 필요(이진분류 절차와 동일, 다만 `roc_auc_score`는 다중분류라 `multi_class='ovr'` 옵션 또는 클래스별 확률 필요) |
| 7. 내보내기 | *(미작성)* | 모델 저장(`joblib`) 및 `test_id` 기준 제출 파일(`submission.csv`) 생성 필요 |

> `ex/01-Copy1.ipynb`는 다중분류와 무관하게 `Binary_Classfication/ex/01.ipynb`(Adult Census 이진분류) 내용을 그대로 복사해둔 흔적 — 이 폴더의 실질적인 다중분류 작업은 `01.ipynb` 하나.

---

## 다음에 볼 것

- `Multiclass_Classfication/ex/01.ipynb`의 06(모델 학습·검증)·07(내보내기) 단계 이어서 작성 필요 — 이진분류 코드에서 `RandomForestClassifier`+`classification_report` 패턴 그대로 가져오되 다중분류 지표(`multi_class` 옵션 등) 확인
- 위 04단계에서 언급한 `cat_cols`/`num_cols` 빈 리스트 이슈 — 노트북 Restart & Run All로 재검증해서 실제 결측치 처리가 되는지 확인 필요
- `Supervised_Learning`에 회귀(Regression) 또는 다른 분류 알고리즘 비교 노트북 추가 여부 확인 필요
- `00/requirements.txt`에 sklearn·pandas 버전 고정 여부 확인 필요 (컨테이너 재빌드 시 버전 드리프트 방지)
