var Quiz = artifacts.require("tic_tac_toe.sol");
const truffleAssert = require("truffle-assertions");

contract("Quiz", accounts => {
	const owner=accounts[0];
	describe("constructor", () => {
		describe("Assert Contract is deployed", () => {
			it("should deploy this contract", async () => {
				const instance = await Quiz.new({ from: owner });
			});
		});
	});

	describe("Register", () => {
		let instance;
		beforeEach(async () => {
			instance = await Quiz.new({ from: owner });
		});
		describe("success case", () => {
			it("1 person can register successfully", async () => {
				await register({from: accounts[1]});
				assert.equal(await instance.player_count.call(),1);
			});
		});
	});

});
