# 필기 목록

<table>
<thead>
<tr><th nowrap>날짜</th><th>요약 키워드</th><th nowrap align="center">링크</th></tr>
</thead>
<tbody>
<tr><td nowrap>7월 28일</td><td>PySpark 학습 환경 구축 — 싱글 노드(SparkSession·SparkContext·RDD·DataFrame·Spark SQL·워드카운트) vs 멀티 노드 클러스터(spark://마스터 연결·rollup 분산 집계), Transformation/Action·Lazy Evaluation·RDD Lineage</td><td nowrap align="center"><a href="./26-7/28일.md">보기</a></td></tr>
<tr><td nowrap>7월 29~30일</td><td>PySpark on Kubernetes(k3s) 클러스터 제출 환경 구축 — spark-submit --deploy-mode cluster 시행착오 7회(driver 이미지·RBAC·S3A 자격증명/DNS), 동적 할당(Dynamic Allocation), History Server(18080)/실시간 Spark UI(4040) 상시 모니터링</td><td nowrap align="center"><a href="./26-7/29-30일.md">보기</a></td></tr>
<tr><td nowrap>7월 31일</td><td>Silver 정제 디버깅(오타 버그·self-join row 폭발 버그), Docker Desktop 리소스 크래시 대응(Bronze Parquet 사전 변환·executor 리소스 제한·repartition 최적화), Gold 레이어 집계 8종 파이프라인, Bronze→Silver→Gold 오케스트레이션 정리</td><td nowrap align="center"><a href="./26-7/31일.md">보기</a></td></tr>
<tr><td nowrap>8월 3~4일</td><td>Spark 설정 우선순위 디버깅(--conf가 코드 hadoop_conf.set()에 덮어써진 사례, 설정은 코드에 안 박고 배포 시점 주입해야 하는 이유·CI 배포 원칙), 레이크하우스 쿼리 스택(Hive Metastore+Trino+Superset) 구축 4대 트러블슈팅(MinIO 리전 누락·Hadoop/AWS SDK 버전 불일치·컨테이너 내 find 부재로 설정 미반영·pip 설치로 인한 SQLAlchemy 버전 충돌), 데이터 시각화 이론(비교/추세/구성/분포/관계별 차트 선택, Pie 함정, BI 대시보드 제작 흐름)</td><td nowrap align="center"><a href="./26-8/3-4일.md">보기</a></td></tr>
</tbody>
</table>
