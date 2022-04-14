module("luci.controller.backone",package.seeall)

function index()
  if not nixio.fs.access("/etc/config/zerotier")then
return
end

entry({"admin","sdwan"}, firstchild(), "BackOne", 45).dependent = false

entry({"admin", "sdwan", "backone"},firstchild(), _("BackOne")).dependent = false

entry({"admin", "sdwan", "backone", "general"},cbi("backone/settings"), _("Base Setting"), 1)
entry({"admin", "sdwan", "backone", "log"},form("backone/info"), _("Interface Info"), 2)
entry({"admin", "sdwan", "backone", "manual"},cbi("backone/manual"), _("Manual Config"), 3)

entry({"admin","sdwan","backone","status"},call("act_status"))
end

function act_status()
local e={}
  e.running=luci.sys.call("pgrep /usr/bin/zerotier-one >/dev/null")==0
  luci.http.prepare_content("application/json")
  luci.http.write_json(e)
end
