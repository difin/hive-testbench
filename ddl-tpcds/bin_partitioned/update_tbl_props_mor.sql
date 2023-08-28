
ALTER TABLE ${DB}.${TABLE} SET TBLPROPERTIES ('write.delete.mode'='merge-on-read');
ALTER TABLE ${DB}.${TABLE} SET TBLPROPERTIES ('write.update.mode'='merge-on-read');
ALTER TABLE ${DB}.${TABLE} SET TBLPROPERTIES ('write.merge.mode'='merge-on-read');
