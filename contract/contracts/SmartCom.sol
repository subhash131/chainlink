// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './FetchProduct.sol';
import './StringUtils.sol';

contract SmartCom is FetchProduct, StringUtils  {
    uint256 counter = 0;
    
    address contrartOwner;
    struct Product{
        uint256 id;
        string name;
        string description;
        string image;
        string price;
        address owner;
    } 
    constructor (string memory _url) FetchProduct(_url){
        contrartOwner = payable(msg.sender);
    }

    event Withdrawal(address indexed account, uint256 amount);
    event Purchase(address indexed account,uint256 productId, uint256 amount);

    mapping (uint256 => Product) public products;

    function addProduct() public {
        // requestId();
        requestImage();
        requestName();
        requestPrice();
        requestDescription();
        products[counter] = Product(counter, name, description, image, price, address(this));
        counter++;
    }

    function getProducts() public view returns(Product[] memory) {
        Product[] memory allProduts = new Product[](counter);
        for(uint256 i = 0; i< counter; i++){
            allProduts[i] = products[i];
        }
        return allProduts;
    }

    function buyProduct(uint256 _pordId) payable public {
        for(uint256 i = 0; i< counter; i++){
            if(products[i].id == _pordId) {
                (uint256 price, bool result) = stringToUint(products[i].price);
                if(result){
                    require( price == msg.value, "Invalid amount");
                    products[i].owner == msg.sender;
                    emit Purchase(msg.sender, products[i].id, msg.value);
                }
            }
        }
    }

    function getBalance () onlyOwner public view returns(uint256){
        return address(this).balance;
    }
    function withdraw() onlyOwner public {
        payable(contrartOwner).transfer(address(this).balance);
        emit Withdrawal(contrartOwner, address(this).balance);
    }

    function getProductById(uint256 prodId) view public returns(Product memory product){
        return products[prodId];
    }
}