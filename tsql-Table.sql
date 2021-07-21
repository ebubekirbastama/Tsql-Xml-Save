--www.ebubekirbastama.com
--İletşim:05554128854
--www.twitter.com/ebubekirstt
--https://www.youtube.com/user/Yazilimegitim/
create table giyimsokagi
(
sysid int primary key identity(1,1),
id nvarchar(max),
stockCode nvarchar(max),
isim    nvarchar(max),
status  nvarchar(max),
marka nvarchar(max),
isOptionedProduct   nvarchar(max),
isOptionOfAProduct  nvarchar(max),   
rootProductIdd    nvarchar(max),
price2  nvarchar(max),
tax  nvarchar(max),
stockAmount  nvarchar(max),  
stock  nvarchar(max),
resim    nvarchar(max),  
picture2Path  nvarchar(max),  
details     nvarchar(max), 
fullDetails   nvarchar(max),   
url  nvarchar(max),    
categoryTree  nvarchar(max),  
kategori_id  nvarchar(max), 
kategori  nvarchar(max),
multipleOptions  nvarchar(max),  
shortdetails nvarchar(max),
shippingDay nvarchar(max)
)
