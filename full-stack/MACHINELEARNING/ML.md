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

## 04_MACHINE_LEARNING — Supervised_Learning · 다중분류 (`Multiclass_Classfication/ex/01.ipynb`, 완성)

Credit Score 데이터(`train.csv` 10만행×28열 / `test.csv` 5만행×27열)로 고객 신용등급을 `Poor`/`Standard`/`Good` 3개 클래스로 분류하는 다중분류 파이프라인. 이진분류(`Binary_Classfication`)와 동일한 스켈레톤(문제정의→가져오기→EDA→전처리→분할·학습→검증→내보내기)을 재사용하되 타겟이 2클래스에서 3클래스로 확장된 버전. **01~07단계 모두 작성·실행 완료**(모델은 `model.pkl`, EDA 리포트는 `report.html`로 저장됨). 08 기타 섹션에 박스플롯 참고 셀이 추가돼 있으나 `plt` import 누락으로 에러 상태.

| 단계 | 코드 | 핵심 |
|---|---|---|
| 1. 문제정의 | 타겟 `Credit_Score` (`Poor`=0/`Standard`=1/`Good`=2) | 3개 등급이 대등해 이진분류처럼 "양성(1)"이라는 개념이 없음 → **ROC-AUC를 못 쓴다**(양성 vs 음성 구도가 전제라서). 채점 지표로 **정확도 + f1(macro)** 사용 — 이진분류와의 핵심 차이가 "몇 종류인가"뿐 아니라 "어떻게 채점하나"까지 바뀐다는 점 |
| 2. IMPORT | `pd.read_csv('train.csv', low_memory=False)` | `low_memory=False`로 혼합타입 `DtypeWarning` 방지. train (100000,28) / test (50000,27) |
| 3. EDA | `head()`, `Credit_Score.unique()`, `describe()`, `info()`, `isnull().sum()`, `value_counts()` | `Age`에 `-500`, `Occupation`에 `_______` 같은 오염 문자열이 그대로 들어있음. 클래스 분포 `Standard 53174 / Poor 28998 / Good 17828`로 약 3배 차이 나는 불균형 |
| 4-1. 오염 체크·자동 수정 | `object` 컬럼마다 `str.replace('_','')` 후 `pd.to_numeric(errors='coerce')`로 숫자 변환 성공 비율 계산 → **90% 이상이면 오염된 숫자 컬럼**으로 판단해 실제 숫자형으로 변환 | `Age`/`Annual_Income`/`Num_of_Loan`/`Outstanding_Debt`는 100%, `Num_of_Delayed_Payment`(93%)/`Changed_Credit_Limit`(98%)/`Amount_invested_monthly`(96%)/`Monthly_Balance`(99%)도 오염 판정 → 8개 컬럼을 문자열에서 숫자로 되돌림. train+test 동일 기준 적용 |
| 4-2. EDA 리포트 (선택) | `ydata_profiling.ProfileReport(train).to_file('report.html')` | 컬럼별 분포·상관관계를 한 번에 훑는 자동 리포트. 오염 수정 **직후**(숫자 변환 전 문자열 오염이 반영 안 된 시점)에 생성돼 있어, 최신 상태를 보려면 재실행 필요 |
| 4-3. 결측치 처리 | 숫자 변환으로 결측이 새로 드러남(train 62162 / test 31112개 셀) → `null_series[(null_series>0) & (dtype조건)]`로 `cat_cols`(`Name`/`Type_of_Loan`/`Credit_History_Age`)·`num_cols`(`Monthly_Inhand_Salary` 등 6개) 분리 후 train 중앙값/최빈값으로 `fillna` | 오염 수정 **이전**엔 결측이 0으로 보였다가, 오염된 문자열이 숫자로 바뀌면서 변환 실패분이 `NaN`으로 드러나는 순서 — "결측 없음"이 데이터 정제 전 착시였을 수 있다는 예시 |
| 4-4. 타겟 분리·컬럼 제거 | `y = train['Credit_Score'].map({...})`; `train.drop(columns=['ID','Customer_ID','Credit_Score'])`; `test.drop(columns=['ID','Customer_ID'])` | 이진분류와 동일한 식별자 제거 패턴 |
| 4-5. 인코딩 | `LabelEncoder`를 `pd.concat([train[col], test[col]])`에 `fit` 후 각각 `transform` | **원핫이 아닌 라벨 인코딩** 선택 — `Name`/`SSN`처럼 카테고리 수가 너무 많은 컬럼에 `get_dummies`를 쓰면 열이 폭발적으로 늘어나므로, 이진분류(`get_dummies`)와 다른 인코딩 전략을 씀. train+test를 합쳐서 `fit`하는 원칙은 동일(인코딩 기준 통일) |
| 5. 검증데이터 분할 | `train_test_split(train, y, test_size=0.2, random_state=0, stratify=y)` | (80000,25) / (20000,25). `stratify=y`로 3개 클래스 비율 유지 |
| 6. 학습·검증 | `RandomForestClassifier(n_estimators=100, random_state=0)` → `accuracy_score`/`f1_score(average='macro')`/`classification_report` | 정확도 0.7885, f1(macro) 0.7751. **`average='macro'`는 다중분류 필수 인자** — 안 주면 "클래스별 f1 3개를 어떻게 합칠지" 몰라 에러가 남 |
| 6-1. macro vs weighted 비교 | `f1_score(..., average='macro')` vs `average='weighted'` | macro 0.7751 < weighted 0.7883. weighted는 개수가 많은 `Standard`(1등급, support 10635, f1 0.81)가 점수를 끌어올리고, 표본이 적고 어려운 `Good`(2등급, support 3566, f1 0.72)은 묻힘. **두 값의 격차가 "소수 클래스가 약하다"는 신호** — 이 단원에서 가장 중요한 포인트로 명시돼 있음 |
| 7. 내보내기 | `joblib.dump(rf, 'model.pkl')` → `joblib.load()`로 재로드 후 예측 일치 검증(`True`) | 이진분류의 `submission.csv` 대신 모델 자체 저장에 집중 — `test_id` 기준 제출 파일 생성 단계는 없음 |
| 8. 기타 | `train.select_dtypes('number').plot(kind='box', subplots=True)` | `plt`(matplotlib) import 없이 `plt.tight_layout()/show()` 호출 → `NameError: name 'plt' is not defined`로 에러 상태. 바로 아래 박스플롯(Q1/Q3/IQR/수염/이상치) 해석 가이드 마크다운 셀은 정상 작성됨 |

> 폴더 안 `01-Copy1.ipynb`는 내용을 확인해보니 실제로는 이 노트북(다중분류)과 완전히 동일 — `03_Liner_Regression` 폴더에 잘못 복사된 파일로 보임(선형회귀 내용 아님).

---

## 04_MACHINE_LEARNING — Supervised_Learning · 선형회귀 (`03_Liner_Regression/01.ipynb`)

BigMart 매출 데이터(`train.csv` 6818행×12열 / `test.csv` 1705행×11열)로 상품별 매출(`Item_Outlet_Sales`, 연속값)을 예측하는 회귀 파이프라인. 분류(이진/다중)와 스켈레톤은 같지만 타겟이 범주가 아닌 **연속 숫자**라 평가지표와 모델이 통째로 바뀐다.

| 단계 | 코드 | 핵심 |
|---|---|---|
| 2. IMPORT | `pd.read_csv('train.csv', low_memory=False)` | train (6818,12) / test (1705,11). 타겟은 `Item_Outlet_Sales`(상품×매장별 매출액, 연속값) — 분류처럼 "몇 종류인가"가 아니라 "얼마인가"를 맞히는 문제라 회귀로 확정 |
| 3. EDA | `info()`, `describe(include="O")`, `select_dtypes('number')`, `num.corr()['Item_Outlet_Sales']`, `sns.heatmap` | 수치형만 뽑아 타겟과의 상관계수부터 확인하는 회귀 전용 습관: `Item_MRP` 0.567(가장 강함, 비쌀수록 매출 큼) > `Item_Weight` 0.02(거의 무관) > `Outlet_Establishment_Year` -0.05 > `Item_Visibility` -0.12(진열 잘 보일수록 오히려 매출 낮음, 약한 역상관) |
| 4. 결측치 처리 | `null_series[(null_series>0) & (dtype조건)]`로 `num_cols`(`Item_Weight`, train 1162개 결측)·`cat_cols`(`Outlet_Size`, train 1940개 결측) 분리 후 train 중앙값/최빈값으로 `fillna` | 이진/다중분류와 동일한 원칙(train 기준 통계만 사용) 그대로 재사용. 타겟(`y`) 분리 후 `train.drop(columns=['Item_Outlet_Sales'])`로 특성에서 제거 |
| 5-1. 단순선형회귀 (특성 1개) | `X1 = train[['Item_MRP']]`(대괄호 2개로 2차원 유지) → `LinearRegression().fit(X1, y)` | 전체 데이터로 먼저 학습: 기울기 15.58, 절편 3.47 → `매출 = 15.58 × MRP + 3.47`. 이후 `train_test_split(X1, y, test_size=0.2, random_state=0)`로 다시 나눠 학습·예측 → **RMSE 1336.2 / MAE 996.6 / R² 0.3123** — 특성이 1개뿐이라 설명력이 약함(R² 0.31 = 매출 변동의 31%만 설명) |
| 5-2. 다중회귀 (전처리) | `X = train.drop(columns=['Item_Identifier','Outlet_Identifier'])`; 컬럼별로 범주형은 최빈값, 수치형은 중앙값으로 `fillna`; `pd.get_dummies(pd.concat([X, X_test], axis=0))` 후 다시 분리 | 식별자 2개(카테고리 수만 많고 예측에 무의미)는 제거, 나머지는 train+test를 합쳐 원핫 인코딩해 더미 열 구성을 통일 → 최종 컬럼 35개 |
| 6. 검증지표 확인 (다중회귀) | `train_test_split(X, y, test_size=0.2, random_state=0)` → `LinearRegression().fit(X_tr, y_tr)` → `mean_squared_error`/`mean_absolute_error`/`r2_score` | **RMSE 1060.4 / MAE 800.2 / R² 0.5669** — 특성 1개(R² 0.31)보다 크게 개선(R² 0.57). 특성을 늘리는 것이 회귀 성능에 직접적으로 기여함을 보여주는 대비 |
| 7. 모델 내보내기 (통계적 검증) | `sm.add_constant(train[['Item_MRP']])` → `sm.OLS(y, Xc).fit()` → `ols.summary().tables[1]` | statsmodels로 **p-value 확인**: `Item_MRP` coef 15.58, P>\|t\| 0.000(유의미) / `const` coef 3.47, P>\|t\| 0.934(유의하지 않음). sklearn이 구한 기울기 15.58과 OLS의 coef가 정확히 일치 — sklearn은 계수만 주고, statsmodels는 그 계수가 통계적으로 믿을 만한지(p-value)까지 알려준다는 역할 차이 |

> 분류(정확도/f1/ROC-AUC)와 달리 회귀는 **RMSE·MAE·R²**로 채점 — 분류의 "이진분류 4가지 결정" 프레임에서 "2)답이 몇 종류인가"가 "연속 숫자"로 답해지는 순간 3)·4)가 통째로 회귀 지표 세트로 바뀐다는 점이 이 단원의 핵심.

---

## 04_MACHINE_LEARNING — Supervised_Learning · 로지스틱 회귀 (`04_Logistic_Regression/01.ipynb`)

건강검진 데이터(`health_survey.csv` 1000행×5열: `age`/`bmi`/`smoker`/`activity_level`/`disease`)로 질병 유무(`disease`, 0/1)를 예측하는 이진분류. 회귀(연속값 예측)에서 다시 분류로 돌아오되, **확률을 출력하는 선형모델**이라는 점이 이번 단원의 핵심 — "회귀"라는 이름이 붙었지만 실제로는 분류 모델이라는 이름의 함정부터 짚는다.

| 단계 | 코드 | 핵심 |
|---|---|---|
| EDA | `df['disease'].value_counts()`(1:588, 0:412, 약 59:41), `df.corr()['disease']`, `groupby(pd.cut(...))` | 상관 1위는 `bmi`(0.21)로 회귀 때보다 훨씬 약함 — 나이대별(`pd.cut`)·흡연 여부별·활동수준별 `disease` 평균을 그룹집계로 뜯어보면 나이가 많을수록(0.483→0.674), 흡연자가(0.566→0.640), 활동이 적을수록(0.647→0.542) 질병 비율이 오른다는 경향이 드러남 |
| 시그모이드 원리 | `z = np.linspace(-8,8,100)`; `sigmoid = 1/(1+np.exp(-z))` | 로지스틱 회귀가 "선형회귀 값(z)을 0~1 확률로 눌러 담는" 함수라는 걸 직접 그려서 확인 — z=0일 때 정확히 0.5(`axhline`로 기준선 표시) |
| 검증 분할 | `train_test_split(X, y, test_size=0.2, random_state=0, stratify=y)` | (800,4)/(200,4). 분류이므로 `stratify=y` 유지 |
| 스케일링 | `StandardScaler().fit_transform(X_tr)` → `transform(X_val)` | **fit은 train에만**, val은 transform만 — 데이터 누수 방지 원칙이 회귀·분류 가리지 않고 그대로 적용 |
| 학습·평가 | `LogisticRegression().fit(X_tr_s, y_tr)` → `predict`/`predict_proba(...)[:,1]` → `accuracy_score`/`roc_auc_score`/`classification_report` | 정확도 0.615, ROC-AUC 0.6271 — 그다지 강한 모델은 아님(특성 4개로는 질병 여부를 설명하기 부족) |
| 계수 해석 | `pd.Series(model.coef_[0], index=X.columns).sort_values(ascending=False)` | `bmi` 0.436(위험↑ 최대) > `age` 0.359(위험↑) > `smoker` 0.116(위험↑) > `activity_level` -0.243(활동 많을수록 위험↓) — 부호로 방향, 크기로 영향력을 동시에 읽음 |
| 스케일링 유무 비교 | 스케일링 O/X 두 모델 나란히 학습·비교 | 정확도(0.615)·AUC(0.6271 vs 0.626)가 **거의 안 변함** — 특성이 4개뿐이고 범위 차이(나이 18~79 vs 흡연 0~1, 약 40배)가 크지 않아 로지스틱 기본 규제(`C=1.0`)의 왜곡이 눈에 띄지 않음. 단, 원본(비스케일링) 계수는 `activity_level` -0.294, `smoker` 0.246처럼 **크기 비교가 왜곡**되어(스케일 안 맞으면 계수 크기로 영향력 비교 불가) 계수 해석 목적이라면 스케일링이 필요 |
| 임계값 튜닝 | `for t in [0.5, 0.3]: pt = (proba>=t).astype(int)` | 임계값 0.5→recall 0.7373/precision 0.6541, 0.3→recall 1.0000/precision 0.6051 — 임계값을 낮추면 "질병 있음"으로 더 많이 판정해 recall은 오르고 precision은 내려가는 트레이드오프를 수치로 확인 |
| 모델 내보내기 | `joblib.dump(model, ...)` + **`joblib.dump(scaler, ...)`** | 스케일러를 안 저장하고 새 환자 원본값을 그대로 넣으면 질병확률이 0.806(정상) → 1.000(스케일러 누락)으로 **완전히 틀어짐** — "스케일러도 모델과 함께 반드시 저장"이 이 단원 최대 경고 포인트 |

### 연습문제 (`ex/`) — 유방암(Breast Cancer) 진단, sklearn 내장 데이터로 같은 파이프라인 재적용

`load_breast_cancer()`(569행×30열, 다운로드/로그인 불필요)로 같은 01~08단계를 반복하되, 본편과 결과가 극단적으로 달라지는 이유를 짚는 문제. `ex/코드.ipynb`는 데이터 로드만 있는 빈 틀이고, 실제 정답은 `ex/정답-checkpoint.ipynb`(해설은 `ex/정답_해설-checkpoint.md`)에 완성돼 있다.

| 단계 | 코드 | 핵심 |
|---|---|---|
| 01 문제정의 | `target_names` = `['malignant','benign']` | **이 과제의 진짜 함정.** 의학의 "양성(benign)"은 "순한 혹, 괜찮다"는 뜻인데 머신러닝의 "양성(positive=1)"은 "찾고 싶은 쪽"이라는 뜻 — 이 데이터에서 `target=1`은 benign(건강한 쪽)이라 **sklearn이 말하는 "양성 클래스"가 오히려 우리가 안 찾고 싶은 쪽**. `target_names`를 안 찍어보면 classification_report를 끝까지 뒤집어 읽게 됨 |
| 03 EDA | `X[['mean area','mean smoothness']].describe()` | `mean area` 143~2501 vs `mean smoothness` 0.05~0.16 — **범위 차이 약 15,000배**(본편은 40배). 클래스 비율은 63:37로 준수한 균형 |
| 04 전처리 | 결측 0, 전부 숫자 | 본편과 동일하게 할 일 없음. 스케일링은 데이터 누수 방지를 위해 05(분할) 이후로 미룸 |
| 05 학습 | `train_test_split` → `StandardScaler`(train만 fit) → `LogisticRegression(max_iter=5000)` | 기본값(`max_iter=100`)으론 수렴 경고 — 특성이 30개로 많아 반복 계산(경사하강)이 더 필요해서 늘림 |
| 06 검증 | `accuracy_score`/`roc_auc_score`/`classification_report(target_names=['악성(0)','양성(1)'])` | **정확도 0.9825, ROC-AUC 0.9957** — 본편(AUC 0.6271)과 같은 로지스틱·같은 코드인데 압도적으로 높음. 모델이 아니라 **데이터(세포 측정치)가 애초에 악성/양성을 잘 가르는 정보를 담고 있어서**임 |
| 06-1 혼동행렬 | `confusion_matrix(y_val, pred)` → `[[40,2],[0,72]]` | 정확도 98%에 만족하면 안 되는 이유: **틀린 2건이 전부 "악성을 양성(건강)으로 놓친" 방향(FN)**, 반대 방향(FP)은 0건 — 의료에서 가장 위험한 실수 패턴이 정확도 숫자 뒤에 숨어있었음 |
| 08-1 임계값과 위험 판단 | `recall_score(y_val, pt, pos_label=0)`로 **악성(0)의 recall**을 임계값별로 비교 | 임계값 0.5→놓친 악성 2명(정확도 0.9825), 0.9→놓친 악성 1명(정확도 0.9386) — 정확도 4%p를 내주고 환자 1명을 더 살리는 트레이드오프. `pos_label=0`이 필요한 이유 자체가 01단계 "양성이 뒤집힌" 함정이 코드로 재등장한 것 |
| 08-2 스케일링 유무 비교 | 스케일링 O(정확도 0.9825) vs X(0.9474) | 본편(4특성, 범위차 40배)은 스케일링 유무가 성능에 무영향이었는데, 여기(30특성, 범위차 15,000배)는 확실히 하락 — 로지스틱 기본 규제(`C=1.0`)가 "범위가 작은 특성"(`mean smoothness`)의 계수만 골라서 누르기 때문. **"스케일링은 성능과 무관하다"는 본편에서의 관찰이 일반 규칙이 아니었음**을 반증 |
| 08-3 계수 해석 | `coef.abs().sort_values(ascending=False)` | 상위 `radius error`(1.325), `worst radius`(0.984) 등 — 크기·모양의 불규칙성이 악성 판단에 크게 기여(상식과 일치). 단 `1=benign`이므로 계수가 **음수여야 악성 쪽을 가리킨다**는 부호 해석 함정이 여기서도 재등장 |

> 본편(AUC 0.63)과 연습문제(AUC 0.9957)의 극단적 차이, 스케일링 무영향→유의미 반전, "양성"의 의미 반전까지 — **같은 알고리즘·같은 코드라도 데이터의 성질(변별력, 특성 범위, 라벨 정의)에 따라 결론이 완전히 달라질 수 있다**는 게 이 단원 전체를 관통하는 교훈.

---

## 04_MACHINE_LEARNING — Supervised_Learning · 성능 개선 (`05_Performance_Improvements/01.ipynb`)

당뇨병 진행도 예측(`load_diabetes`, 442행×10열, 연속 타겟)을 소재로 지금까지 써온 **"한 번 분할해서 검증"** 방식의 한계를 짚고, 교차검증·규제·하이퍼파라미터 튜닝·파이프라인 순서로 더 신뢰할 수 있는 평가·개선 방법을 익히는 단원. 새 모델을 배우는 게 아니라 **같은 `LinearRegression`을 더 정직하게 평가하고 다듬는 법**이 주제.

| 단계 | 코드 | 핵심 |
|---|---|---|
| 1. 단일 분할의 한계 | `train_test_split` → `LinearRegression().fit(X_tr, y_tr)` → `r2_score` | 단일 분할 R² 0.3322 — 이 값은 **어떤 20%가 뽑혔는지에 따라 운으로 흔들릴 수 있는 숫자**라는 문제 제기가 다음 단계로 이어짐 |
| 2. 교차검증 | `cross_val_score(LinearRegression(), X, y, cv=5, scoring='r2')` | 데이터를 5등분해 번갈아 검증셋으로 써서 5개 점수(`[0.43, 0.523, 0.483, 0.426, 0.55]`) 평균 **R² 0.4823** — 단일 분할(0.33)보다 높고 안정적. "운 좋은/나쁜 20%" 하나에 의존하지 않고 5번 평가한 평균이라 더 믿을 만함 |
| 3. 규제 모델 비교 | `Ridge(alpha=1)` vs `Lasso(alpha=0.1)`를 각각 `cross_val_score`로 비교 | Ridge 평균 R² 0.4102, Lasso 평균 R² 0.4795 — 같은 교차검증 틀 위에 모델만 바꿔 끼워 공정 비교. 이 데이터에서는 규제가 약한 Lasso가 기본 `LinearRegression`(0.4823)에 더 근접 |
| 4. 하이퍼파라미터 튜닝 | `GridSearchCV(Ridge(), {'alpha':[0.01,0.1,1,10,100]}, cv=5, scoring='r2').fit(X_tr, y_tr)` | 최적 `alpha=0.01`, 최적 CV R² 0.5267 — 그런데 이 최적값으로 `X_val`을 예측한 **진짜 검증 R²는 0.33**으로 뚝 떨어짐. GridSearchCV가 고른 "최고 점수"는 train 내부 교차검증 점수이지, 한 번도 안 본 진짜 검증셋 점수가 아니라는 **점수 착시**를 실측으로 확인 |
| 5. 파이프라인 | `make_pipeline(StandardScaler(), Ridge(alpha=1))` → `cross_val_score(pipe, X, y, cv=5)` | 평균 R² 0.4822 — 3번의 Ridge(0.4102)와 비슷한 값이지만, 여기서는 **스케일링이 매 fold의 train에만 `fit`되고 검증 fold는 transform만 적용**되어 폴드 간 정보가 새지 않는 게 핵심. 숫자보다 "누수 없이 얻은 정직한 점수"라는 점이 이 단계의 요점 |

> 4번(GridSearchCV best_score_)과 5번(pipeline cross_val_score)을 나란히 보면, **"교차검증 점수가 왜 이렇게 높게 나오지?"라는 의심이 들 때 파이프라인으로 전처리까지 폴드 안에 가두고 다시 재봐야 한다**는 실전 점검 습관으로 이어짐.

### 연습문제 (`ex/`) — 와인 품질(Wine Quality) 데이터로 baseline→튜닝 흐름 재적용

레드와인 품질 데이터(`plotly/datasets` CSV, URL로 바로 로드)에 `RandomForestRegressor`로 같은 "교차검증 baseline → GridSearchCV 튜닝" 흐름을 적용하는 문제. 정답은 `ex/정답.ipynb`, 해설은 `ex/정답_해설.md`.

| 단계 | 코드 | 핵심 |
|---|---|---|
| 1. baseline | `cross_val_score(RandomForestRegressor(random_state=0), X, y, cv=5, scoring='r2').mean()` | **baseline 평균 R² 0.3118** — 튜닝 전 기준점을 먼저 숫자로 고정 |
| 2. GridSearchCV 튜닝 | `GridSearchCV(RandomForestRegressor(random_state=0), {'n_estimators':[100,300],'max_depth':[None,10,20]}, cv=5, scoring='r2').fit(X, y)` | 최적 파라미터 `{'max_depth':10, 'n_estimators':300}`, 최적 CV R² **0.3181** — baseline 대비 개선폭이 겨우 0.0063으로 **미미함** |
| 3. 트레이드오프 정리 | (생각해보기) | 후보 조합 `2×3=6`가지 × `cv=5`폴드 = **30번 학습**을 돌려서 얻은 개선이 0.006 수준 — 튜닝은 "후보 수 × fold 수"만큼 비용이 드므로, 향상폭이 작다면 **하이퍼파라미터를 더 뒤지기보다 데이터·특성 쪽을 개선하는 게 효율적**일 수 있다는 결론 |

> 01(당뇨, `Ridge`/`Lasso`)과 `ex`(와인, `RandomForestRegressor`) 모두 **"교차검증으로 baseline을 먼저 잡고, GridSearchCV로 같은 CV 틀 안에서 후보를 비교한다"**는 동일한 절차를 다른 모델·다른 데이터에 반복 — 모델 종류가 바뀌어도 성능 개선 절차 자체는 그대로 재사용된다는 게 이 단원의 핵심 패턴.

---

## 04_MACHINE_LEARNING — Unsupervised_Learning · 군집화 K-Means (`Unsupervised_Learning/01Clustering`)

지도학습(정답 라벨 있음)에서 **비지도학습**(정답 없이 구조만 찾음)으로 넘어가는 첫 단원. K-Means로 "라벨 없이 비슷한 것끼리 묶기"를 연습한다. 폴더 구성은 이후 Unsupervised_Learning 하위 폴더 전반에서 반복되는 패턴: `Level1→Level2→Level3`가 난이도순 연습, `예시.ipynb`는 별도의 정제된 정답 예시, `01.ipynb`는 주석 없이 여러 실험을 몰아 쓴 강사용 초안(끝에 미완성 빈 셀 있음).

| 파일 | 데이터셋 | 코드 | 핵심 |
|---|---|---|---|
| Level1 | `load_iris().data`(150,4), 스케일링 없음 | `KMeans(n_clusters=3, random_state=0, n_init=10)` | 군집 크기 `[62,50,38]` — setosa 50개는 한 군집으로 완벽히 분리, versicolor/virginica는 두 군집에 섞임(48+14, 2+36). 라벨 없이도 종 구조를 상당히 복원한다는 첫 확인 |
| Level2 | `load_wine().data`(178,13) | `StandardScaler` → `KMeans(n_clusters=3, random_state=0, n_init=10)` | 단위 차이가 큰 특성(알코올 ~12 vs 마그네슘 ~100대)엔 스케일링이 필수라는 점을 명시. 실루엣 점수 **0.285** — 양수지만 뚜렷한 군집은 아님("보통 0.5 이상이 뚜렷") |
| Level3 | Mall Customers CSV(URL, 200행), `Annual Income`·`Spending Score` 2개 특성만 사용 | `StandardScaler` → `KMeans(n_clusters=5)` | 실루엣 **0.555**. 세그먼트 5개를 사람이 직접 해석 — VIP(고소득·고소비 39명), 알뜰형(고소득·저소비 35명), 충동형(저소득·고소비 22명), 소극형(저소득·저소비 23명), 일반형(중간 81명). **모델은 숫자 0~4만 내놓고 이름은 사람이 붙인다**는 점을 명시 |
| 예시(정답) | `load_iris(as_frame=True)` | `make_pipeline(StandardScaler(), KMeans(n_clusters=3, random_state=0, n_init=10))` | Level1과 달리 스케일링을 **파이프라인**으로 묶어 군집 크기가 `[53,50,47]`로 달라짐(스케일링 유무 차이가 결과 자체를 바꿈). 군집별 평균 꽃잎 길이(1.46/4.37/5.51)가 분리 기준임을 확인 — "꽃잎 크기"라는 특성을 라벨 없이 스스로 찾아낸 것 |
| 01.ipynb(초안) | iris·wine·Mall Customers 세 데이터를 한 파일에서 순서대로 실험 | 동일 기법 반복 + 엘보우 기법(`inertia_`, k=1~10 곡선) | wine 실루엣 0.268, Mall Customers 실루엣 0.555로 Level 파일들과 수치 일치 — 정제되지 않은 스크래치 노트로, Level1~3의 원재료 역할 |

> Level1→Level2→Level3는 "스케일링 불필요(iris) → 스케일링 필수(wine) → 실제 데이터+세그먼트 해석(Mall Customers)" 순으로 난이도가 오르고, `예시.ipynb`는 같은 iris를 파이프라인 패턴으로 다시 보여주며 **스케일링 여부에 따라 군집 결과 자체가 달라진다**는 걸 재확인시킨다.

---

## 04_MACHINE_LEARNING — Unsupervised_Learning · 차원축소 PCA (`Unsupervised_Learning/02Dimensionality_Reduction`)

PCA(주성분분석)로 "특성이 많아도 핵심 정보는 몇 개 축에 담겨있다"를 확인하는 단원. 폴더 구성은 Clustering과 동일(Level1~3 난이도순 + 예시 별도 답안 + 01 초안).

| 파일 | 데이터셋 | 코드 | 핵심 |
|---|---|---|---|
| Level1 | `load_iris().data`(150,4), 스케일링 없음 | `PCA(n_components=2)` | `explained_variance_ratio_` `[0.92, 0.05]`, 합 **0.97** — 4차원을 2차원으로 줄여도 정보의 97%가 남음. iris는 사실상 "2차원짜리" 데이터라는 결론, PCA의 가장 큰 효용은 산점도로 시각화가 가능해진다는 점 |
| Level2 | `load_breast_cancer().data`(30특성) | `StandardScaler` → `PCA().fit()`(전체 성분) → `cumsum(explained_variance_ratio_)`로 0.95 넘는 지점 탐색 | 95% 분산을 유지하려면 30개 중 **10개** 성분이면 충분 — 차원을 1/3로 줄이면서 정보 대부분 보존. "몇 개로 줄일까"를 고정값이 아니라 **설명분산 비율 기준**으로 정하는 법을 익힘 |
| Level3 | UCI Wine Quality(red) CSV(URL, 세미콜론 구분, 1599행×12열), `quality` 제외 11특성 | `StandardScaler` → `PCA(n_components=2)` | 설명분산 합 **0.46**밖에 안 됨 — iris(0.97)와 달리 특성 간 중복·상관이 적어 2축으로는 부족. 더 많은 성분(95% 기준)이나 원본 특성을 쓰는 편이 나을 수 있음을 시사 |
| 예시(정답) | `load_wine().data`(13특성) | `StandardScaler` → `PCA(n_components=2)`, 이어서 `PCA(n_components=0.95)`(분산비율 지정) | 축 2개 설명분산 합 0.55. `n_components=0.95`처럼 정수 대신 **비율(float)을 넣으면 95% 달성에 필요한 성분 수(13개 중 10개)를 자동 선택** — 고정 개수 API와 분산기준 API 두 가지 사용법을 나란히 대비 |
| 01.ipynb(초안) | iris + UCI Wine Quality(red) | PCA+KMeans 조합 실험 | iris: PCA(2)+KMeans(2) 실루엣 0.706 vs 원본 4D KMeans(2) 실루엣 0.681로 PCA 후가 근소하게 우세. wine-quality는 **스케일링을 빠뜨린 채** PCA를 적용한 방법론적 실수가 섞여있음(Level3·예시는 스케일링을 제대로 적용) — 그럼에도 설명분산 합은 우연히 0.46으로 동일하게 나옴 |

> iris(0.97)·wine quality(0.46)의 극단적 차이가 이 단원의 핵심 — "PCA는 항상 잘 압축된다"가 아니라 **데이터의 특성 간 상관관계가 강할수록만 적은 축으로 압축된다**는 걸 두 데이터셋 대비로 확인. Level2의 "95% 기준으로 성분 수 정하기"와 예시의 `n_components=0.95` API가 실전에서 바로 이어지는 흐름.

---

## 04_MACHINE_LEARNING — Unsupervised_Learning · 연관규칙 Association Rule (`Unsupervised_Learning/03Association Rule`)

mlxtend의 `apriori`+`association_rules`로 장바구니 데이터에서 "A를 사면 B도 산다"는 규칙을 찾는 단원. 지표 정의(예시.ipynb에 명시): **support**=전체 중 해당 조합이 등장한 비율, **confidence**=A를 산 사람 중 B도 산 비율, **lift**=confidence를 "B를 그냥 살 확률"로 나눈 값(1보다 크면 양의 연관, 1이면 무관, 1보다 작으면 음의 연관).

폴더에 두 세트의 파일이 공존한다: 번호+`_LEVEL`/`_EX` 접두 파일(`01_LEVEL`~`04_EX`)은 **빈 템플릿**(셀 하나, 내용 없음)이고, 실제 내용은 `01_예시.ipynb`(4개 미니 실습을 한 파일에 몰아 쓴 초안)와 정제된 `Level1~Level3`+`예시.ipynb`에 들어있다. `01_예시`의 4개 섹션이 각각 Level1(TransactionEncoder)·Level2(lift 정렬)·Level3(실제 Groceries 데이터)·예시(수작업 딕셔너리 인코딩)로 나뉘어 재구성된 것으로 보인다.

| 파일 | 데이터셋 | 코드 | 핵심 |
|---|---|---|---|
| 예시(정답) | 5개 영수증(라면/계란/우유/콜라/빵), 수작업 딕셔너리 인코딩 | `apriori(min_support=0.4)` → 6개 itemset → `association_rules(metric='lift', min_threshold=1.0)` | 4개 규칙, 대표로 계란→라면(support 0.6, confidence 1.00, lift 1.25)을 실제 매대 배치 전략("계란 옆에 라면 진열")으로 연결해 해석 |
| Level1 | 동일 5-트랜잭션 데이터, `TransactionEncoder` 사용 | `apriori(min_support=0.4)` → `association_rules(metric='confidence', min_threshold=0.6)` | 3개 규칙(라면→계란, 계란→라면, 콜라→라면 모두 lift 1.25) — `TransactionEncoder`가 수작업 딕셔너리 인코딩을 자동화해줌을 확인. 임계값을 낮추면 규칙이 늘고 높이면 강한 규칙만 남는 트레이드오프 |
| Level2 | 8개 영수증(우유/빵/버터/계란) | `apriori(min_support=0.3)` → `association_rules(metric='lift', min_threshold=1.0)`, lift 내림차순 정렬 | 최상위 계란↔빵, lift **1.14**(계란→빵 confidence 1.00, 빵→계란 confidence 0.571) — lift로 정렬하면 "가장 강하게 묶인 조합"이 먼저 나온다는 걸 확인 |
| Level3 | **실제 Groceries 데이터**(urllib로 CSV 다운로드, 9,835건 → 원핫 인코딩 (9835,169)) | `apriori(min_support=0.02)` → 122개 itemset → `association_rules(metric='confidence', min_threshold=0.3)`, lift 정렬 | 최상위 규칙 {whole milk, other vegetables}→{root vegetables}, support 0.023 / confidence 0.310 / **lift 2.84**. 약 37개 규칙 도출 — 실제 매대 배치·묶음 할인·추천 시스템의 근거로 활용 가능하다는 결론 |
| 01_예시(초안) | 위 4개(5건 수작업/5건 TransactionEncoder/8건/Groceries) 실습을 한 파일에 순서대로 진행 | 동일 apriori 흐름 반복 | Level1~3+예시로 나중에 분리된 원본 초안. 파이썬 배경이 약한 학습자를 위해 딕셔너리 컴프리헨션 옆에 동등한 for문 의사코드 주석을 달아둔 점이 특이 |
| 01_LEVEL~04_EX(빈 파일) | - | - | 셀 1개, 내용 없음 — Level1~3+예시로 분리하려다 만 미완성 스텁 |

> 5건(교과서용) → 8건(lift 정렬 연습) → 9,835건(실제 데이터)로 표본 규모가 커질수록 "그럴듯한 규칙"이 통계적으로 더 신뢰할 만해진다는 감각을 쌓는 게 이 단원의 흐름. 실제 Groceries 데이터의 lift 2.84가 이 폴더에서 나온 가장 강력한 연관규칙.

---

## 04_MACHINE_LEARNING — Unsupervised_Learning · 이상치 탐지 Outlier Detection (`Unsupervised_Learning/04Outlier_detect`)

IsolationForest(모델 기반)와 IQR(사분위수 기반) 두 가지 이상치 탐지 기법을 다루는 단원. `Level1~Level3`는 IsolationForest만으로 난이도를 올리고, `예시_1_ForestIsolation`→`예시`→`예시_2_사분위수` 3개 파일이 breast_cancer 데이터 하나로 "탐지 → 성능 검증 실험 → IQR과의 비교"까지 이어지는 별도의 심화 흐름을 이룬다.

| 파일 | 데이터셋 | 코드 | 핵심 |
|---|---|---|---|
| Level1 | 합성 2D 데이터: 정상 100개(`rng.normal`) + 인위적 이상치 8개(`rng.uniform(-6,6)`) = 108개 | `IsolationForest(contamination=0.1).fit_predict()` | 108개 중 **11개**를 이상치(-1)로 탐지 — `contamination=0.1`(전체의 10% 가정)과 대략 일치, 심어둔 이상치 8개 대부분을 잡아냄. 실전에서는 미리 이상치를 알 수 없다는 점을 명시(이 합성 데이터는 개념 확인용) |
| Level2 | `load_wine(as_frame=True)`(178,13) | `StandardScaler` → `IsolationForest(contamination=0.05)`의 `fit_predict`(이진 판정) + `decision_function`(연속 점수, 낮을수록 이상) 병행 | 178개 중 **9개**(~5%) 이상치. 점수 오름차순 정렬로 "가장 이상한 순서"까지 랭킹화 — Level1엔 없던 `decision_function` 활용이 핵심 추가 |
| Level3 | UCI Wholesale Customers CSV(URL, 440행×8열 중 소비 특성 6개) | `StandardScaler` → `IsolationForest(contamination=0.05)` | 440개 중 **22개**(5%) 이상치. 최고 이상치 고객은 신선식품 36,847·우유 43,950 등 전방위로 큰 구매액 — 사기 탐지·불량 탐지·대량구매 고객 식별 등 실전 활용처를 연결 |
| 예시_1_ForestIsolation | `load_breast_cancer`(30특성) | `StandardScaler` → `IsolationForest(contamination=0.05)` | 569개 중 **29개**(~5%) 이상치, 540개 정상 — IsolationForest 기본 메커니즘만 소개하는 간결한 버전(예시.ipynb의 초기 draft로 보임) |
| 예시(정답, 심화) | 위와 동일 데이터·설정 + **다운스트림 검증 실험** | `anomaly==1`인 540행만 남긴 `df_clean`으로 재학습: `LogisticRegression`을 (a)원본 훈련데이터 (b)이상치 제거 후 훈련데이터로 각각 학습해 같은 테스트셋으로 비교 | **정확도 0.947→0.947, ROC-AUC 0.992→0.992로 변화 없음.** "이상치 제거가 늘 이득은 아니다" — 이미 깨끗한 데이터에서는 5% 제거해도 성능이 그대로라는 걸 실측, 결과 확인 없이 "이상치니까 제거"하면 안 된다는 결론 |
| 예시_2_사분위수 | 동일 breast_cancer, **IQR(사분위수) 방식**으로 전환 | 단일 특성(`mean area`) Q1=420.3/Q3=782.7/IQR=362.4로 정상범위 `[-123.3, 1326.3]` 계산 → 이 컬럼 하나만으로 25개 이상치. 전체 30개 특성에 컬럼별 IQR 적용 후 "특성당 벗어난 횟수" 집계 | **569개 중 171개(30%)**가 하나 이상의 특성에서 이상치로 잡힘(IsolationForest의 5%보다 훨씬 많음). 최다 이탈 행(122·108·78·212·461번)이 IsolationForest가 찾은 최고 이상치 순위와 겹쳐 두 기법이 서로 교차검증됨. 같은 로지스틱회귀 검증 실험 결과 **정확도 0.947→0.956(소폭 개선), ROC-AUC 0.992→0.991(거의 그대로)** — 훈련데이터 30%를 지워서 얻은 개선이 미미해 "많이 지운다고 좋아지는 게 아니다"라는 결론 |

> 노트북 마지막 정리가 이 단원 전체의 결론: **한 특성이 대놓고 튀면 IQR(박스플롯)로 충분하고, 여러 특성의 조합이 이상하면(개별로는 정상 범위인데 함께 보면 이상) IsolationForest가 필요하다.** 단변량 vs 다변량 이상치 탐지의 차이, 그리고 "이상치 탐지 후에는 반드시 다운스트림 성능으로 검증한다"는 습관이 핵심.

---

## 04_MACHINE_LEARNING — 시각화 Visualization (`visualization`)

matplotlib·seaborn을 이용한 시각화 3종(선 그래프·히스토그램·산점도)에서 seaborn 내장 데이터셋(분포·박스플롯), 외부 CSV(상관관계 히트맵)까지 난이도를 올리는 단원. `Level1`과 `예시`는 같은 합성 데이터·같은 3가지 차트를 각각 "한 화면에 subplot으로" vs "그래프마다 따로" 그리는 차이로 대비되고, `Level2`·`Level3`는 실제 데이터로 기법을 확장한다.

| 파일 | 데이터셋 | 기법 | 핵심 |
|---|---|---|---|
| Level1 | 합성 데이터 3종: 사인파(100pt), 정규분포 나이(500명, 평균35/표준편차10), 광고비-매출(50쌍, `sales=ad*2.5+noise`) | `plt.subplots(1,3)` 한 화면에 line/hist/scatter | 광고비-매출 산점도에서 양의 상관(우상향) 확인. **한 Figure에 여러 서브플롯을 나란히 배치**하는 것이 이 파일의 핵심 기법 |
| 예시(정답) | Level1과 동일한 3종 생성 로직(고정 시드가 없어 값은 다름) | line/hist/scatter를 **각각 별도 figure**로 출력, 히스토그램엔 `plt.axvline(age.mean())`로 평균선 추가 | 마무리 코멘트로 **"목적(변화/분포/관계)에 맞는 그래프를 고르는 것이 시각화의 절반"** — 선=변화, 히스토그램=분포, 산점도=관계라는 목적별 차트 선택 기준을 명시적으로 정리 |
| Level2 | `sns.load_dataset('tips')`(244행×7열: total_bill/tip/sex/smoker/day/time/size) | `sns.histplot(kde=True)` + `sns.boxplot(x='day', y='total_bill')` | 총 지불액은 $10~20에 몰리고 오른쪽 꼬리가 긴 분포, 요일별 boxplot으로 주말이 더 높은 경향 확인. **한글 제목은 깨질 수 있어 영문 제목을 쓴다**는 실전 팁이 주석으로 명시(이후 Level3에도 이어짐) |
| Level3 | 펭귄 데이터 CSV(seaborn-data 저장소 URL) `.dropna()` 후 333행×7열 | `select_dtypes('number')` → `.corr()` → `sns.heatmap(annot=True, cmap='coolwarm')` | 상관계수: `flipper_length_mm`↔`body_mass_g` **0.87**(최고), `bill_length_mm`↔`flipper_length_mm` 0.65, `bill_depth_mm`는 나머지 특성들과 전부 음의 상관(-0.23~-0.58) — 히트맵 하나로 여러 변수 간 관계를 한눈에 파악하는 게 Level2의 1:1 비교(boxplot)에서 한 단계 나아간 지점 |

> 데이터 소스가 numpy 생성값(Level1/예시) → seaborn 내장 데이터셋(Level2) → 외부 URL의 실제 공개 데이터(Level3)로 단계적으로 실전에 가까워지는 구성. 색상 관례(선=주황, 히스토그램=하늘색, 산점도=보라)를 노트북 전체에서 일관되게 써서 "차트 종류-용도"를 몸에 익히도록 한 점도 공통.

---

## STREAMLIT — Streamlit 웹앱 실습 (`STREAMLIT/`)

Jupyter 노트북 실습과 별도로, 학습한 모델을 **웹 화면으로 서비스하는 법**을 다루는 단원. `01_INIT → 02_UI → 03_MODELADD` 3단계로 진행되며, 각 폴더는 이전 폴더를 복사해 이어 만든 구조(`app.py`/`pages/page1~3.py`/`docker-compose.yml`/`requirements.txt` 동일 스켈레톤 반복)라 **폴더가 늘어날수록 앱에 기능이 하나씩 얹힌다**. 세 폴더 모두 `pages/page1~3.py`는 빈 파일로 남아있어(멀티페이지 앱 확장은 아직 실습 전 단계), 실제 내용은 각 폴더의 `app.py`에 있다. `docker-compose.yml`은 세 폴더가 동일 — `python:3.10-slim` 컨테이너에 `requirements.txt`를 `/tmp`로 마운트해 `pip install` 후 `streamlit run app.py --server.port=8501`을 실행하고, 호스트 `8601`→컨테이너 `8501`로 포트를 매핑. `STREAMLIT_SERVER_RUN_ON_SAVE=true`로 저장 시 자동 새로고침, `FILE_WATCHER_TYPE=poll`로 도커 환경에서의 파일 변경 감지 불안정성을 보완.

### `01_INIT` — 도커 환경 초기 세팅

| 파일 | 상태 | 핵심 |
|---|---|---|
| `docker-compose.yml` | 작성 완료 | 이후 02_UI·03_MODELADD가 그대로 재사용하는 기준 설정(포트 8601:8501, bind mount, `RUN_ON_SAVE`) |
| `requirements.txt` | 작성 완료 | `streamlit==1.28.0`, `pandas==2.1.0`, `numpy==1.24.3`, `scikit-learn==1.3.0`, `joblib==1.3.2`, `lightgbm==4.1.0`, `matplotlib`, `watchdog` — 버전 고정 |
| `app.py`, `pages/page1~3.py` | **빈 파일** | 이 단계는 "컨테이너가 뜨고 Streamlit 서버가 응답하는지"만 확인하는 환경 구축 단계 — 앱 코드는 아직 없음 |

### `02_UI` — Streamlit 위젯·레이아웃 전체 훑기 (`app.py`)

`docker-compose.yml`·`requirements.txt`는 01_INIT과 동일. `data.csv`(32,561행, Adult Census 소득 데이터 — `04_MACHINE_LEARNING/Binary_Classfication`과 같은 계열의 데이터)가 폴더에 추가돼 다운로드 버튼 실습에 쓰이지만, 이 단계에서는 아직 모델과 연동되지 않고 단순 첨부 파일로만 쓰인다.

| 주제 | 코드 | 비고 |
|---|---|---|
| 텍스트 출력 | `st.title/header/subheader/write/markdown/caption/code` | 마크다운 문법(`**굵게**`), 코드 블록(`language="python"`)까지 한 번에 훑음 |
| 입력 위젯 | `st.text_input`, `st.number_input(min_value·max_value·value)`, `st.selectbox`, `st.slider`, `st.checkbox`, `st.toggle` | 위젯 반환값이 바로 파이썬 변수(`name`, `age`, `job`...)에 담긴다는 걸 `st.write(name, age, job, lvl, agree, dark)`로 확인 |
| 버튼·이벤트 | `if st.button("인사하기", type="primary"): st.success(...)` | 버튼은 클릭된 순간에만 `if` 블록이 실행(Streamlit의 매 상호작용마다 스크립트 전체가 재실행되는 방식) |
| 파일 다운로드 | `Path("data.csv").read_bytes()` → `st.download_button(data=csv_bytes, file_name=...)` | `df.to_csv()`로 즉석 생성하는 방법(주석 처리됨)과 기존 파일을 그대로 읽어 내려주는 방법 두 가지를 코드에 나란히 남겨둠 |
| 표·차트 | `st.dataframe(hide_index, use_container_width)`(읽기전용 표), `st.data_editor(num_rows="dynamic")`(수정 가능한 표), `st.line_chart`/`st.bar_chart`/`st.area_chart` | 랜덤 생성 `DataFrame(20,3)`으로 표와 3종 차트를 한 번에 시연 |
| 레이아웃 | `st.columns(2)`(가로 분할), `st.tabs([...])`(탭 전환), `st.sidebar`(왼쪽 고정 메뉴), `st.expander`(접었다 펴기) | `with col1:`/`with tab1:`처럼 컨텍스트 매니저로 위젯을 특정 영역에 배치하는 패턴 |
| 상태 유지 | `if "count" not in st.session_state: st.session_state.count = 0` → 버튼 클릭마다 `+= 1` | Streamlit은 상호작용마다 스크립트가 처음부터 다시 실행되므로, 값을 재실행 간에 유지하려면 **세션 상태**가 필수라는 걸 카운터로 체감 |
| 폼 | `with st.form("my_form"): ... st.form_submit_button("제출")` | 폼 안 위젯은 개별 입력마다 재실행되지 않고 **제출 버튼을 눌러야만** 한 번에 처리됨 — 입력 위젯 하나하나가 리런을 유발하는 것과의 차이 |

### `03_MODELADD` — 학습된 모델 연동 (`app.py`)

`requirements.txt`가 최신 버전으로 갱신됨(`streamlit`/`lightgbm` 버전 고정 해제, `pandas 2.2.3`·`numpy 2.2.6`·`scikit-learn 1.6.1`·`joblib 1.4.2`로 상향) — 새 sklearn/numpy로 재학습한 모델과 맞추기 위한 것으로 보임. `train.py`는 **빈 파일**이라 `model.pkl`을 만든 학습 코드 자체는 노트북에 남아있지 않지만, `model.pkl`은 실제로 존재(약 1.1MB)하며 `{"model":..., "features":[...], "target":[...]}` 형태의 **번들 딕셔너리**로 저장돼 있다.

| 단계 | 코드 | 핵심 |
|---|---|---|
| 모델 로드 | `@st.cache_resource def load_bundle(): return joblib.load("model.pkl")` | `st.cache_resource`로 모델을 **한 번만 로드**해 캐싱 — 매 상호작용마다 스크립트가 재실행되는 Streamlit 특성상, 캐싱이 없으면 클릭할 때마다 모델을 다시 읽어들이는 비효율이 생김 |
| 입력 폼 | `st.form`으로 나이·교육수준·주당근로시간 3개 `number_input` 받고 `form_submit_button("예측하기")` | 02_UI에서 익힌 폼 패턴을 그대로 재사용 — 세 값을 한 번에 제출해야 예측이 실행됨 |
| 예측 | `X = pd.DataFrame([[age, educationNum, hoursPerWeek]], columns=features)` → `model.predict(X)[0]`, `model.predict_proba(X)[0]` | 저장된 번들의 `features` 리스트로 입력 컬럼 순서를 맞춰 학습 때와 동일한 형태의 DataFrame을 구성 — Jupyter 노트북(`joblib.dump(model,...)`)에서 반복된 "저장한 그대로 재현" 원칙이 여기서도 이어짐 |
| 결과 표시 | `st.success(f"예상 소득: {target[pred]}")`, `st.bar_chart(pd.Series(proba, index=target))` | 클래스 라벨(`target`)도 모델과 함께 번들에 저장해뒀다가 예측 인덱스를 사람이 읽을 수 있는 이름으로 바로 매핑 — 클래스 순서를 하드코딩하지 않는 안전한 패턴 |

> `sys.modules["numpy._core"] = numpy`라는 주석 처리된 줄이 남아있는데, 이는 **구버전 numpy로 저장한 `model.pkl`을 신버전 numpy·`requirements.txt`(2.2.6)에서 불러올 때 발생하는 모듈 경로 불일치를 우회하려던 흔적**으로 보인다 — 실제로 주석 처리돼 비활성화된 걸 보면 이번 버전 조합에서는 필요 없었거나, 문제가 재현될 때를 대비한 임시 처방으로 남겨둔 것.

> 01_INIT(환경만) → 02_UI(위젯 전체를 모델 없이 훑기) → 03_MODELADD(캐싱된 모델을 폼 입력과 연결해 실제 예측 서비스)로 이어지는 흐름 — Jupyter에서 학습·저장한 모델(`joblib.dump`)을 실제 사용자 화면으로 넘기는 마지막 단계라는 게 이 폴더 전체의 의미.

