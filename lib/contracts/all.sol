pragma solidity ^0.8.0;
import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Agent is ERC721{
    uint public nextTokenId;
    address public admin;
    constructor()ERC721('Autonet Project','ATP'){
        admin=msg.sender;
    }
    function mint(address to)external{
        require(msg.sender==admin,'only admin');
        _safeMint(to,nextTokenId);
        nextTokenId++;
    }
    function _baseURI() internal view override returns (string memory)
    {return "https://us-central1-afterme-850af.cloudfunctions.net/NFT/";}
}

contract Project{
    Agent model;
    string code;
    string public picurl;
    string public category;
    string public name;
    string public description;
    string public catpicgit;
    MainToken banu;
    bool mature=false;
    mapping(address=>uint8) public shareholders;
    uint256 public spentOnTraining;
    
    constructor(
        address adresaLaBanu, 
        string memory _name,
        string memory _code,
        string memory _description,
        string memory _picurl,
        string memory _category,
        address founder)
        payable{
        banu=MainToken(adresaLaBanu);
        name=_name;
        code=_code;
        category=_category;
        description=_description;
        picurl=_picurl;
        shareholders[founder]=100;
        catpicgit=append(category,picurl,code);
    }
    
    function balanceATN() public view returns (uint256){
        return banu.balanceOf(address(this));
    }
    
    function append(string memory a, string memory b, string memory c) internal pure returns (string memory) {
    return string(abi.encodePacked(a, b, c));
}
    
    function details() public view returns (string memory,string memory,string memory){
        return (name,description,catpicgit);
    }
    
    function back()public payable{}
}

contract User{
    address public owner;
    MainToken banu;
    Source source;
    mapping(address=>uint) public assets;
    constructor(address adresaLaBanu,address adresaLaOwner){
        owner=adresaLaOwner;
        source=Source(msg.sender);
        banu=MainToken(adresaLaBanu);
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner,"Only the owner of the contract can call this function.");
        _;
    }
    
    function createProject(
        string memory _name,
        string memory _description,
        string memory _code,
        string memory _iconurl,
        string memory _category
        )
    public onlyOwner{
        address project=source.createProject(_name,_description,_code,_iconurl,_category);
        assets[project]=100;
    }
}

contract Source {
    mapping(address=>address) public users;
    address public sefu;
    MainToken banu;
    address[] public projects;
    uint256 initialPrice=1000000000000000;
    address public tokenAddress;
    uint256 sold;
    constructor(){
        sold=0;
        sefu=msg.sender;
        banu=new MainToken();
        tokenAddress=address(banu);
        banu.imprima(1000000);
    }
    
    function allProjects() public view returns(address[] memory)  {
        return projects;
    }
    
    function createUser()public returns(address){
        User user=new User(tokenAddress,msg.sender);
        users[msg.sender]=address(user);
        return address(user);
    }
    
    function createProject(
        string memory _name,
        string memory _description,
        string memory _code,
        string memory _iconurl,
        string memory _category
        )public payable returns(address){
            Project project=new Project(address(banu),_name,_code,_description,_iconurl,_category,address(msg.sender));
            projects.push(address(project));
            return(address(project));
        }

    function buy()public payable {
        uint256 cashu=msg.value*1000;
        require(sold+cashu<banu.totalSupply(),
        "Total supply limit was reached. Trade amongst yourselves now.");
        require(cashu<500000000000000000000, "Can't buy more than 500 ATN.");
        banu.transfer(msg.sender,cashu);
    }
}

contract MainToken is ERC20 {
    address owner;
    constructor ()  ERC20("AUTONET", "ATN") {
        owner=msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"Only the owner of the contract can call this function.");
        _;
    }
    
    function imprima(uint256 amount)public onlyOwner{
         _mint(msg.sender, amount * (10 ** uint256(decimals())));
    }
    
}


