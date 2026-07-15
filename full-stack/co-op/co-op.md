# 협업도구

---

## 1. Git

git은 형상관리도구이지만 협업 도구인 깃허브 연동을 위한 도구 중 하나

---

### 1) 전역 설정

- git config --global user.email "your email"
- git config --global user.name "your nickname"
- git config --list

---

### 2) 기본 명령어

- git init : Working directory 생성
- git add
- git commit

---

### 3) 확인 명령어

- git log
- git log --oneline

---

### 4) 되돌리기

- git reset --soft
- git reset --hard
- git option

  - hard  
    : 돌아간 커밋 이후의 변경 이력을 전부 삭제  
    : working directory까지 리셋  
    : tracked된 상태여야 함

  - soft  
    : 변경 이력 삭제  
    : 변경 내용은 남아있음  
    : 인덱스 초기화 (git add가 안되어 있는 상태)

  - mixed  
    : 변경 이력 삭제  
    : 변경 내용은 남아있음  
    : 인덱스 유지 (git add까지 되어 있음)

- git reflog
- git rm --cached filename  
  (tracked file → untracked file)

---

### 5) Branch

- git branch  
  : 브랜치 목록 확인

- git branch 브랜치이름  
  : 브랜치 생성

- git switch 브랜치이름  
  : 브랜치 전환

- git checkout 브랜치이름  
  : 브랜치 전환 + 여러 기능 포함

---

### 6) 병합하기

- git merge 브랜치이름  
  : git switch로 병합 위치 선정 후 merge 실행

---

#### 병합 방식

- Fast-Forward  
  : 커밋 생성 없음  
  : merge 기본 옵션

- non-Fast-Forward  
  : 커밋 생성 있음  
  : git merge 브랜치이름 --no-ff

  - --no-ff 사용 시 커밋 메시지 입력 창이 열림  
    종료 : :wq

  - git merge 브랜치이름 --no-ff -m "커밋내용"  
    : 바로 커밋 이름과 함께 생성

- git merge --continue  
  : 충돌 발생 후 파일 수정  
  : git add로 스테이징  
  : 병합 이어서 진행

---

#### 병합 전략

- 병합 후 main 브랜치 이외의 브랜치도 head를 맞춰야 함

- 브랜치 목록  
  - main  
  - dev  
  - user1

- user 브랜치 → dev 병합  
- dev -> main 병합  

이때 dev -> main 병합은 --no-ff 사용 시 관리에 용이함

---

## 2. GitHub

---

### 1) 깃허브 가져오기

- git clone  
  : 최초로 원격 저장소를 가져올 때

- git pull  
  : 원격 저장소에서 가져온 후 즉시 반영

- git fetch  
  : 원격 저장소에서 가져오기 (병합 없음)

---

### 2) 깃허브에 저장하기

- git push  
  : 원격 저장소에 업로드

---

### 3) 깃허브 권한

현재는 organization을 생성해서 권한을 부여해야함  

브랜치 구조  
- main(팀장) : branch rules(x - Lock Branch)
  - develop(팀장) : branch rules(pull request 유도)
    - feature1(팀원)
    - feature2
    - feature3

브랜치 룰에서 권한을 수정하여 브랜치를 lock하거나 풀 수 있음  
팀원이 생성하면 풀 리퀘스트로 요청으로 처리해서 팀장이 승인(merge) 및 삭제를 할 수 있음  
리뷰 방식으로 n개 이상 코멘트 달면 pull되도록 가능  

---

### 4) organization

1. organization 생성  
2. repository 생성  
3. branch 생성(main, dev)  
4. 팀원 초대  
  - organization -> settings -> collaborators and teams -> add people
5. 권한 설정  
  - organization -> settings -> member privileges -> write
6. repositoy's branch rule 설정  
  - organization -> repositoy -> settings -> branch ->main :lock branch / dev :require a pull request before merging

[팀장 - 팀원 병합처리]
dev -> main 으로 pull request 확인 및 병합 승인처리  

[팀원]
1. organization의 repositoy 확인
2. 본인이름/기능명 branch 생성
3. dev branch에 pull request요청
4. 서로 approve 댓글 추가해서 dev에 merge해보기

---

### 5) issue

new issue를 통해 이슈 생성가능  
이슈 : [기획] 유스케이스 - 홍길동  
- [x] 요구사항 확인 정리
- [ ] 가나다라

생성 후 내가 생성한 이슈를 들어가 오른쪽 메뉴에서 깃브랜치를 생성하고 복사  
이후 작업 후 내 브랜치에 저장 한 다음 깃허브의 내 브랜치에서 pull request 요청가능  

---

### 6) project

new project를 통해 보드 생성 가능  
이슈로 연동 가능

---

## 3. SourceTree

---

### 1) GitHub 연동

1. local_repo → GitHub push  
2. GitHub repo(README) → SourceTree로 가져오기

---

### 2) Rebase

다른 분기로 작업 중에 기반 분기에서 작업이 계속 이루어지고 있다면 이를 최신화 반영해주는 것  
히스토리 정리

---

## 4. Git Flow

---

브랜치 구조  

- main  
- release  
- dev  
- feature  

---

## 5. Eclipse + Git

---

1. Eclipse → Toolbar(Window) → Show View → Other 에서 Git UI 추가  
2. Package Explorer → 프로젝트(RMB) → Team → Share Project로 git init  
3. 이후 Team에서 git commit, push, pull, merge 가능

---

## 6. JIRA

---

### 1) 개요

Atlassian에서 개발한 이슈 추적 및 프로젝트 관리 도구  
애자일 기법 적용  
스프린트, 백로그, 칸반 보드, 워크플로우 등을 통한 작업 추적과 협업에 강점

---

### 2) 주요 개념

| 용어 | 설명 |
|------|------|
| 이슈(Issue) | 작업 단위 (예: 버그, 기능, 요청 등) |
| 프로젝트(Project) | 이슈들이 속한 단위 그룹 (팀/제품 단위 관리) |
| 워크플로우(Workflow) | 이슈의 상태 전이 흐름 (To Do → In Progress → Done 등) |
| 보드(Board) | 이슈를 시각화하는 UI (Kanban, Scrum 등) |
| 스프린트(Sprint) | 일정 기간 동안 수행할 작업 묶음 (Scrum 방식에서 사용) |
| 백로그(Backlog) | 우선순위가 지정된 이슈 목록 |
| 컴포넌트(Component) | 프로젝트 내 하위 모듈 또는 분류 |
| 에픽(Epic) | 여러 작업(이슈)을 묶은 큰 단위 기능 |
| 스토리(Story) | 사용자 관점의 요구사항, 일반적인 개발 단위 |

---

### 3) 타임라인

- 타임라인에서 에픽 생성
- 에픽 밑에 스토리 같은 작업 추가 생성 가능
- 타임라인에서 기간 지정 후 캘린더에 표시

---

### 4) 이슈 단위

| 종류 | 설명 |
|------|------|
| Story | 사용자 관점의 기능 요구사항 |
| Task | 일반적인 작업 단위 |
| Bug | 결함 또는 오류 |
| Epic | 여러 Story를 묶는 큰 단위 |
| Sub-task | 하위 작업 (Task 내부 분리 가능) |

---

### 5) 자동화 · 할당

- 자동화 기능으로 github 연동으로 풀리퀘스트 가능
- 이슈 생성 후 각 작업자에게 할당

---

### 6) JIRA 페이지 - 컨플루언스

페이지를 만들고 이를 타임라인이나 보드 등에 연동 가능

명령어

| 입력 | 설명 |
|------|------|
| @ | 작업자 연동 |
| /jira | 지라 에픽이나 스토리, 작업 생성 및 할당 연동 가능 |

---

### 7) JIRA + Github 연동

| 단계 | 내용 |
|------|------|
| 1 | Github Oranization 생성 |
| 2 | Repository 생성(Private or Public상관없음) |
| 3 | Jira 프로젝트 생성 |
| 4 | GitHub for Atlassian 설치 |
|  | - 왼쪽카테고리 '앱' -> 더많은 앱 살펴보기 ->  GitHub for Atlassian 설치 |
| 5 | Jira - Github 연동(GitHub for Atlassian -> Get Started ->) |
| 6 | 보드에서 새 작업 생성 |
| 7 | 생성된 작업 키 복사 |
| 8 | 깃허브에서 feature/복사된키 로 브랜치 생성 |
| 9 | 보드 새로고침 후 브랜치 연결 확인 |

---

### 8) 자동화

| 단계 | 내용 |
|------|------|
| 1 | 스페이스 설정 |
| 2 | 자동화 |
| 3 | 규칙만들기 |
| 4 | 처음부터 만들기 |
| 5 | when 설정 |
| 6 | then 설정 |
| 7 | 규칙활성화 후 네임 설정 |

깃허브에 웹형식으로 요청할 때

https://api.github.com/repos/ORANIZATIONANME/REPOSITORYNAME/dispatches

METHOD  : POST

웹 요청 본문 : 사용자정의

{
  "event_type": "jira-issue-created",
  "client_payload": {
    "issue_type": "{{issue.issueType.name}}",
    "issue_key": "{{issue.key}}",
    "summary": "{{issue.summary.jsonEncode}}",
    "description": "{{issue.description.jsonEncode}}",
    "jira_url": "{{issue.url}}"
  }
}

Authorization   token github accestoken
Content-Type   application/json
Accept      application/vnd.github.v3+json

깃허브에 워크플로우 yml파일 생성

name: Jira Automation

on:
  repository_dispatch:
    types: [jira-issue-created]

jobs:
  create-issue-and-branch:
    runs-on: ubuntu-latest
    permissions:
      issues: write
      contents: write
    steps:
      - name: GitHub 이슈 생성
        id: create_issue
        uses: actions/github-script@v7
        with:
          script: |
            const issueType = context.payload.client_payload.issue_type;
            const summary = context.payload.client_payload.summary;
            const description = context.payload.client_payload.description || '';
            const jiraUrl = context.payload.client_payload.jira_url;

            const labelMap = {
              'Epic': 'epic',
              'Task': 'task',
              'Story': 'story',
              'Feature': 'enhancement',
              'Bug': 'bug'
            };

            const issue = await github.rest.issues.create({
              owner: context.repo.owner,
              repo: context.repo.repo,
              title: `[${issueType.toUpperCase()}] ${summary}`,
              body: `Jira: ${jiraUrl}\n\n## 체크리스트\n${description}`,
              labels: [labelMap[issueType] || 'task']
            });

            return issue.data.number;

      - name: Jira 이슈에 GitHub 링크 추가 (Remote Link)
        uses: actions/github-script@v7
        env:
          JIRA_BASE_URL: ${{ secrets.JIRA_BASE_URL }}
          JIRA_EMAIL: ${{ secrets.JIRA_EMAIL }}
          JIRA_API_TOKEN: ${{ secrets.JIRA_API_TOKEN }}
        with:
          script: |
            const issueKey = context.payload.client_payload.issue_key;
            const jiraUrl = context.payload.client_payload.jira_url;
            const issueNumber = ${{ steps.create_issue.outputs.result }};

            if (!issueKey || !jiraUrl) {
              core.warning('Jira issue_key 또는 jira_url이 payload에 없습니다. Jira 링크 추가를 건너뜁니다.');
              return;
            }

            const jiraBaseUrlFromSecret = (process.env.JIRA_BASE_URL || '').trim();
            const jiraEmail = (process.env.JIRA_EMAIL || '').trim();
            const jiraToken = (process.env.JIRA_API_TOKEN || '').trim();

            if (!jiraEmail || !jiraToken) {
              core.warning('JIRA_EMAIL/JIRA_API_TOKEN 시크릿이 없어 Jira 링크 추가를 건너뜁니다.');
              return;
            }

            let jiraBaseUrl = jiraBaseUrlFromSecret;
            if (!jiraBaseUrl) {
              try {
                const u = new URL(jiraUrl);
                jiraBaseUrl = u.origin;
              } catch (e) {
                core.warning(`jira_url 파싱 실패: ${String(e)}. Jira 링크 추가를 건너뜁니다.`);
                return;
              }
            }

            const owner = context.repo.owner;
            const repo = context.repo.repo;
            const githubIssueUrl = `https://github.com/${owner}/${repo}/issues/${issueNumber}`;

            const auth = Buffer.from(`${jiraEmail}:${jiraToken}`).toString('base64');
            const endpoint = `${jiraBaseUrl.replace(/\/+$/, '')}/rest/api/3/issue/${encodeURIComponent(issueKey)}/remotelink`;

            const payload = {
              object: {
                url: githubIssueUrl,
                title: `GitHub Issue #${issueNumber}`,
                icon: {
                  url16x16: 'https://github.githubassets.com/favicons/favicon.png',
                  title: 'GitHub'
                }
              }
            };

            const res = await fetch(endpoint, {
              method: 'POST',
              headers: {
                'Authorization': `Basic ${auth}`,
                'Accept': 'application/json',
                'Content-Type': 'application/json'
              },
              body: JSON.stringify(payload)
            });

            if (!res.ok) {
              const text = await res.text().catch(() => '');
              core.warning(`Jira remotelink 추가 실패 (${res.status}): ${text}`);
              return;
            }

            core.info(`Jira(${issueKey})에 GitHub Issue 링크 추가 완료: ${githubIssueUrl}`);

      - name: GitHub 브랜치 생성 및 Issue 직접 연결
        uses: actions/github-script@v7
        with:
          script: |
            const issueType = context.payload.client_payload.issue_type;
            const issueKey = context.payload.client_payload.issue_key;
            const summary = context.payload.client_payload.summary;
            const issueNumber = ${{ steps.create_issue.outputs.result }};

            const prefixMap = {
              'Epic': 'epic',
              'Task': 'task',
              'Story': 'story',
              'Feature': 'feature',
              'Bug': 'bugfix'
            };

            const prefix = prefixMap[issueType] || 'feature';

            // 이슈 제목 브랜치명 처리 (공백→하이픈, 특수문자 제거, 소문자 변환, 최대 50자)
            const sanitizedSummary = summary
              .toLowerCase()
              .replace(/\s+/g, '-')
              .replace(/[^a-z0-9ㄱ-ㅎ가-힣-]/g, '')
              .replace(/-+/g, '-')
              .replace(/^-|-$/g, '')
              .substring(0, 50);

            const branchName = `${prefix}/${issueKey}-${sanitizedSummary}`;

            // 1. develop SHA 조회
            const develop = await github.rest.git.getRef({
              owner: context.repo.owner,
              repo: context.repo.repo,
              ref: 'heads/develop'
            });
            const developSha = develop.data.object.sha;

            // 2. Issue Node ID 조회
            const issueData = await github.rest.issues.get({
              owner: context.repo.owner,
              repo: context.repo.repo,
              issue_number: issueNumber
            });
            const issueNodeId = issueData.data.node_id;

            // 3. Repo Node ID 조회
            const repoData = await github.rest.repos.get({
              owner: context.repo.owner,
              repo: context.repo.repo
            });
            const repoNodeId = repoData.data.node_id;

            // 4. createLinkedBranch로 브랜치 생성 + Issue 직접 연결
            await github.graphql(`
              mutation($issueId: ID!, $branchName: String!, $repoId: ID!, $oid: GitObjectID!) {
                createLinkedBranch(input: {
                  issueId: $issueId,
                  name: $branchName,
                  repositoryId: $repoId,
                  oid: $oid
                }) {
                  linkedBranch {
                    id
                    ref {
                      name
                    }
                  }
                }
              }
            `, {
              issueId: issueNodeId,
              branchName: branchName,
              repoId: repoNodeId,
              oid: developSha
            });

            // 5. 브랜치 생성 댓글
            await github.rest.issues.createComment({
              owner: context.repo.owner,
              repo: context.repo.repo,
              issue_number: issueNumber,
              body: `브랜치 생성 완료: \`${branchName}\``
            });

---

### 9. JIRA + SLACK
| 단계 | 내용 |
|------|------|
| 1 | SLACK 다운로드 |
| 2 | SLACK 워크스페이스 생성 |
| 3 | SLACK에 APP 들어가기 |
| 4 | JIRA CLOUDE 설치 및 추가 |
| 5 | JIRA의 프로젝트와 연결 |
| 6 | /jira create 명령어로 이슈 생성 |

