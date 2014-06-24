require "CREDDExchangeLib"

local NoAsk = Apollo.GetPackage("Gemini:Addon-1.1").tPackage:NewAddon("YouNoAskCancel", false, { "MarketplaceListings", "NeighborList" }, "Gemini:Hook-1.0" )


function NoAsk:OnEnable()
   self.mp = Apollo.GetAddon("MarketplaceListings")
   self:RawHook(self.mp, "OnCancelBtn")

   self.nbl = Apollo.GetAddon("NeighborList")
   self:RawHook(self.nbl, "OnVisitBtn")
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

function NoAsk:OnVisitBtn(luaCaller, wndHandler, wndControl)
   local tCurrNeighbor = wndControl:GetData()
   if tCurrNeighbor == nil then
      return
   end
   HousingLib.VisitNeighborResidence(tCurrNeighbor.nId)
   self.timer = ApolloTimer.Create(0.01, false, "CloseWindow", self)
   self.nbButton  = wndControl
end

function NoAsk:CloseWindow()
   self.timer = nil
   if self.nbButton then 
      self.nbButton:SetCheck(false)
      self.nbButton = nil
   end
end
