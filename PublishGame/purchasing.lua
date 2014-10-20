-- START:require
require( "store" )
-- END:require

-- START:initVariables
-- Initialise the in-app purchase variables
backgroundUnlocked = 0
currentStore = ""
productsList = {}
buyButtons = display:newGroup( )
-- END:initVariables

-- START:transactionCallback
-- Handle app transactions
function transactionCallback( event )
    if event.transaction.state == "purchased" then
        -- Success! 
        backgroundUnlocked = 1
        print( "the user bought the background" )
        backgroundImg.isVisible = true
        buyButtons.isVisible = false
    end
    
    store.finishTransaction( event.transaction )
end
--END:transactionCallback

-- START:addStoreLib
-- Store permissions
if store.availableStores.apple then
    store.init("apple", transactionCallback)
elseif store.availableStores.google then
    store.init("google", transactionCallback)
end
--END:addStoreLib

-- START:setProductList
-- The list of products for iOS devices
local productListIOS = 
{
    "com.createMobileGamesWithCorona.MyGame.BackgroundImage",
}
-- The product list for google store items
--   Note: these are the reserved item IDs for testing purchases
local googleProductList =
{
    {
        title = "Background Image",
        description = "A shiny background image",
        productIdentifier = "android.test.purchased",
        price = 0.99
        
        -- use android.test.canceled or 
        --   android.test.item_unavailable for alternate testing results
    }
}
-- END:setProductList

-- START:purchaseFunc
-- Purchase an item from the product list
function purchaseBG( event )
    if ( event.phase == "ended" ) then
        store.purchase( { productsList[1].productIdentifier } )
    end
end
--END:purchaseFunc

-- START:getProductList
-- Show the products using button widgets
function showProductSaleImages( )
    for i = 1, #productsList do
        local myButton = widget.newButton{
            id = "btn"..i,
            left = 75,
            top = 450 - 50 * i,
            label = "Buy "..productsList[i].price,
            width = 170, height = 40,
            cornerRadius = 8,
            emboss = true,
            labelColor = { default={ 1, 1, 1 } },
            onEvent = purchaseBG
        }
        buyButtons:insert( myButton )
    end
end

-- Load the product information and display it
if store.canLoadProducts then
    -- iOS: load the product list (online)
    currentStore = "apple"
    productsList = productListIOS
    store.loadProducts( productListIOS, productsLoaded )
else
    -- Android: Add the data manually
    currentStore = "android"
    productsList = googleProductList
    showProductSaleImages( )
end
--END:getProductList

-- START:productsLoadedFunc
-- Set the loaded products on iOS
function productsLoaded( event )
    -- Store the product list
    productsList = event.products
    -- Call the display image
    showProductSaleImages( )
end
--END:productsLoadedFunc

