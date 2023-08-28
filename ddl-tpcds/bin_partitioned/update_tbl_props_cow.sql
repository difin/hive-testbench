
ALTER TABLE ${DB}.${TABLE} SET TBLPROPERTIES ('write.delete.mode'='copy-on-write');
ALTER TABLE ${DB}.${TABLE} SET TBLPROPERTIES ('write.update.mode'='copy-on-write');
ALTER TABLE ${DB}.${TABLE} SET TBLPROPERTIES ('write.merge.mode'='copy-on-write');
