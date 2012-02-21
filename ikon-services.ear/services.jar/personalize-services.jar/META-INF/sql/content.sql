[get-page-info]
select * from sys_content_page where path=$P{path} 

[get-content]
select content from sys_content_fragment where pageid=$P{pageid} and section=$P{section}
