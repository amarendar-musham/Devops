SET objRootDSE = GETOBJECT("LDAP://RootDSE") 
strExportFile = "C:\TEMP\MyExport.xls"  
 
strRoot = objRootDSE.GET("DefaultNamingContext") 
strfilter = "(&(objectCategory=Person)(objectClass=User)(!userAccountControl:1.2.840.113556.1.4.803:=2))" 
strAttributes = "sAMAccountName,displayName,mail,company,manager,homePhone,mobile," 
strScope = "subtree" 
SET cn = CREATEOBJECT("ADODB.Connection") 
SET cmd = CREATEOBJECT("ADODB.Command") 
cn.Provider = "ADsDSOObject" 
cn.Open "Active Directory Provider" 
cmd.ActiveConnection = cn 
 
cmd.Properties("Page Size") = 1000 
 
cmd.commandtext = "<LDAP://" & strRoot & ">;" & strFilter & ";" & _ 
                                   strAttributes & ";" & strScope 
 
SET rs = cmd.EXECUTE 
 
SET objExcel = CREATEOBJECT("Excel.Application") 
SET objWB = objExcel.Workbooks.Add 
SET objSheet = objWB.Worksheets(1) 
 
for x = 0 to rs.Fields.count -1
	'msgbox( rs.fields(x).name )	
next
 
FOR i = 0 to rs.Fields.Count - 1 
                objSheet.Cells(1, i + 1).Value = rs.Fields(i).Name 
                objSheet.Cells(1, i + 1).Font.Bold = TRUE 
NEXT 
 
objSheet.visible = true
 
objSheet.Range("A2").CopyFromRecordset(rs) 
objWB.SaveAs(strExportFile)  
 
rs.close 
cn.close 
SET objSheet = NOTHING 
SET objWB =  NOTHING 
objExcel.Quit() 
SET objExcel = NOTHING 
 
Wscript.echo "Script Finished..Please See " & strExportFile
