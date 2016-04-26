create table inodetail as select inode,max(filename),bkname,size,type,modify_d from files group by inode,bkname,size,type,modify_d;

