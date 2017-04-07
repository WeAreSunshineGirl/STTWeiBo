---创建微博数据---
CREATE TABLE IF NOT EXISTS "T_Status" (
"statusId" integer NOT NULL,
"userId" integer NOT NULL,

"status" text,
"createTime" text DEFAULT (datetime('now','localtime')),
PRIMARY KEY ("statusId","userId")
);