--www.ebubekirbastama.com
--İletşim:05554128854
--www.twitter.com/ebubekirstt
--https://www.youtube.com/user/Yazilimegitim/

USE tempdb
GO

IF OBJECT_ID('tempdb..#xml') IS NOT NULL DROP TABLE #xml
CREATE TABLE #xml ( yourXML XML )
GO

DECLARE @EBSURL VARCHAR(8000)

select @EBSURL = 'http://www.giyimsokagi.com/index.php?do=catalog/output&pCode=3322881871'

-- Veri Çekme Kalıbı...
DECLARE @EBSResponse varchar(8000)
DECLARE @EBSXML xml
DECLARE @EBSObj int
DECLARE @EBSResult int
DECLARE @EBSHTTPStatus int
DECLARE @EBSErrorMsg varchar(MAX)

EXEC @EBSResult = sp_OACreate 'MSXML2.XMLHttp', @EBSObj OUT

EXEC @EBSResult = sp_OAMethod @EBSObj, 'open', NULL, 'GET', @EBSURL, false
EXEC @EBSResult = sp_OAMethod @EBSObj, 'setRequestHeader', NULL, 'Content-Type', 'application/x-www-form-urlencoded'
EXEC @EBSResult = sp_OAMethod @EBSObj, send, NULL, ''
EXEC @EBSResult = sp_OAGetProperty @EBSObj, 'status', @EBSHTTPStatus OUT

INSERT #xml ( yourXML )
EXEC @EBSResult = sp_OAGetProperty @EBSObj, 'responseXML.xml'--, @Response OUT


DECLARE @EBSDocHandle int
DECLARE @EBSXmlDocument nvarchar(1000)

set @EBSXmlDocument = (select CAST(yourXML as nvarchar(max)) FROM #xml)


USE [Db_KitapDataları]
GO

Declare @EBSCount int


set @EBSCount = (SELECT yourXML.value('count(/urunler/urun/id)[1]','VARCHAR(MAX)') from #xml)



DECLARE @cnt int = 0;


WHILE @cnt < @EBSCount
BEGIN
declare @sql as nvarchar(max)

-- İnsert verileri
set @sql='insert into giyimsokagi'

set @sql=@sql+' select(SELECT yourXML.value(''(//products/product/id)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/stockCode)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/isim)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/status)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/marka)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/isOptionedProduct)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/isOptionOfAProduct)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/rootProductId)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/price2)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/tax)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/stockAmount)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/stock)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/resim)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/picture2Path)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/details)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/fullDetails)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/url)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/categoryTree)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/kategori_id)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/kategori)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/multipleOptions)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/shortdetails)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'
set @sql=@sql+',(SELECT yourXML.value(''(//urunler/urun/shippingDay)['+convert(varchar,@cnt)+']'',''VARCHAR(MAX)'') from #xml)'


exec sp_executesql @sql


--İnsert verileri

SET @cnt = @cnt + 1;
END;

