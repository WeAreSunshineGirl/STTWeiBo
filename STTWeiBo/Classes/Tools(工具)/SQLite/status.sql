---创建微博数据---
CREATE TABLE IF NOT EXISTS "T_Status" (
"statusId" integer NOT NULL,
"userId" integer NOT NULL,

"status" text,PRIMARY KEY ("statusId","userId")
);