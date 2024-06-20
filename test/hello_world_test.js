const HelloWorld = artifacts.require("HelloWorld");

contract("HelloWorld",()=>{
    if("Testing", async () =>{
        const instance = await HelloWorld.deployed();
        await instance.setMessage("How are you");
        const message = await instance.message;
        assert(message === "How are you");

    });
})