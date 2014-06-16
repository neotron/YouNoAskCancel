require "CREDDExchangeLib"

local NoAsk = Apollo.GetPackage("Gemini:Addon-1.1").tPackage:NewAddon("YouNoAskCancel", false, { "MarketplaceListings" }, "Gemini:Hook-1.0" )


function NoAsk:OnEnable()
   self.mp = Apollo.GetAddon("MarketplaceListings")
   self:RawHook(self.mp, "OnCancelBtn")
end

function NoAsk:OnCancelBtn(luaCaller, wndHandler, wndControl)
   local aucCurrent = wndHandler:GetData()
   if not aucCurrent then return end
   if wndHandler:GetName() == "CommodityCancelBtn" or wndHandler:GetName() == "AuctionCancelBtn" then
      aucCurrent:Cancel()
   else
      CREDDExchangeLib.CancelOrder(aucCurrent)
   end
   luaCaller:RequestData()
end
