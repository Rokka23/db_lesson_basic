-- Q1 新しいテーブルの追加 --
CREATE TABLE departments(
  department_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Q2 peopleテーブルにカラムを追加 --
ALTER TABLE 
  people 
ADD 
  department_id INT UNSIGNED 
AFTER 
  email;


-- Q3 レコードの作成 --
-- departments クエリ --
INSERT INTO 
  departments (name)
VALUES 
  ('営業'),
  ('開発'),
  ('経理'),
  ('人事'),
  ('情報システム');

-- people --

INSERT INTO 
  people (name, email, department_id, age, gender)
VALUES  
  ('新井太郎', 'arai@gizumo.jp', 1, 28, 1),
  ('佐藤花子', 'satou@gizumo.jp', 1, 25, 2),
  ('高橋健', 'takahashi@gizumo.jp', 1, 32, 1),
  ('前田大輔', 'maeda@gizumo.jp', 2, 27, 1),
  ('中村彩', 'nakamura@gizumo.jp', 2, 29, 2),
  ('山本亮', 'yamamoto@gizumo.jp', 2, 30, 1),
  ('伊藤真由美', 'ito@gizumo.jp', 2, 24, 1),
  ('小林誠', 'kobayashi@gizumo.jp', 3, 33, 1),
  ('加藤恵', 'kato@gizumo.jp', 4, 26, 2),
  ('松本航', 'matsumoto@gizumo.jp', 5, 31, 1);



-- reportsクエリ --
INSERT INTO 
  reports (person_id, content)
VALUES  
  (37, '新規クライアント向けの資料を作成しました。'),
  (38, '問い合わせ対応と見積書の送付を行いました。'),
  (39, '契約済みの顧客へのフォロー電話を実施しました。'),
  (40, '新規機能追加に伴うデータベース設計を見直しました。'),
  (41, 'フロンエンドのレイアウト崩れを修正しました。'),
  (42, '開発チームでコードレビューを実施しました。'),
  (43, '新入社員向けの開発環境構築マニュアルを作成しました。'),
  (44, '月次の経費精算を処理しました。'),
  (45, '採用面接のスケジュール調整を行いました。'),
  (46, '社内ネットワークの設定変更と動作確認を行いました。');



-- Q4 peopleテーブルの部署IDを修正 --
UPDATE 
  people 
SET 
  department_id = 2 
WHERE 
  name IN ('高橋健', '前田大輔', '中村彩', '山本亮', '伊藤真由美');


-- Q5 年齢降順で男性の名前と年齢取得 --
SELECT 
  name, age 
FROM 
  people 
WHERE 
  gender = 1 
ORDER BY 
  age DESC;


-- Q6 日本語説明 --
peopleテーブルからname,email,ageの３つのカラムを対象にdepartment_idが１のレコードを作成日時を基準に昇順に取得。


-- Q7 20代女性と40代男性の名前一覧を取得 --
SELECT  
  name 
FROM  
  people 
WHERE  
  (age BETWEEN 20 AND 29 AND gender=2)
OR  
  (age BETWEEN 40 AND 49 AND gender=1);


-- Q8 営業部に所属する人だけを年齢の昇順で取得 --
SELECT 
  name 
FROM 
  people 
WHERE
  department_id = 1 
ORDER BY 
  age ASC;


-- Q9 開発部に所属している女性の平均年齢を取得 --
SELECT 
  AVG(age) AS average_age 
FROM 
  people 
WHERE 
  department_id = 2 
AND 
  gender = 2;


-- Q10 名前と部署名をその人が提出した日報の内容を同時に取得 --
SELECT 
  p.name, d.name AS department_name, r.content 
FROM 
  people 
INNER JOIN 
  departments d 
ON 
  p.department_id = d.department_id

INNER JOIN 
  reports r 
ON 
  p.person_id = r.person_id;


-- Q11 日報を一つも提出していない人の名前一覧を取得 --
SELECT 
  people.name 
FROM 
  people 
LEFT JOIN 
  reports 
ON 
  people.person_id = reports.person_id
WHERE 
  reports.person_id IS NULL;