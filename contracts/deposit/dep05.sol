pragma solidity ^0.4.15;

contract m05 {

    address icoInitiator;
	address commissionAddress;
	address investmentAddress;

    string icoName="";
	//https://www.unixtimestamp.com/
	uint256 icoDateEnd = 1514678400; // 12/31/2017 @ 12:00am (UTC)
	uint256 investmentLimit = 0;
	uint256 totalAmount = 0;

	uint256 commissionPercentage = 1;

	mapping(address => uint) investmentPending;

    function m05(
        string _icoName,
        uint256 _icoDateEnd, 
		uint256 _investmentLimit, 
		uint256 _commissionPercentage, 
		address _commissionAddress, 
		address _investmentAddress
    ) {

		icoInitiator = msg.sender;
        icoName = _icoName;
        icoDateEnd = _icoDateEnd;
		investmentLimit = _investmentLimit;
		commissionPercentage = _commissionPercentage;
		commissionAddress = _commissionAddress;
		investmentAddress = _investmentAddress;

    }

    function Invest() payable {
		
		uint256 commissionAmount = (msg.value * commissionPercentage) / 100;
		//Send(msg.sender, commissionAddress, commissionAmount);
		commissionAddress.transfer(commissionAmount);
        investmentPending[msg.sender] += (msg.value - commissionAmount);
		totalAmount += (msg.value - commissionAmount);
    }

    function repayInvest(){

		if (totalAmount < investmentLimit * 1000000000000000000) {

			uint256 repayAmount = investmentPending[msg.sender];
			investmentPending[msg.sender] = 0;
			totalAmount -= repayAmount;
			msg.sender.transfer(repayAmount);
		}
    }

    function InvestsConfirm(){

		if (totalAmount >= investmentLimit * 1000000000000000000) {

			investmentAddress.transfer(totalAmount);
			totalAmount = 0;
		}
    }

  function BalanceOf(address _owner) public constant returns (uint256) {

    return investmentPending[_owner];
  }

  function InvestmentLimit() public constant returns (uint256) {

    return investmentLimit;
  }

  function TotalAmount() public constant returns (uint256) {

    return totalAmount / 1000000000000000000;
  }

}
