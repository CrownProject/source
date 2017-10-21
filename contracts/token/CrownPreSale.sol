contract CrownPreSale {
    
    address owner;

    CrownPreSaleToken public token = new CrownPreSaleToken();

    function CrownPreSale() {
        owner = msg.sender;
    }
    
    function() external payable {
        owner.transfer(msg.value);
        token.mint(msg.sender, msg.value);
    }
}
