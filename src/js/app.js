App = {
    web3Provider: null,
    contracts: {},
    account: 0x0,

    init: function() {
        return App.initWeb3();
    },

    initWeb3: function() {
        if (typeof web3 !== 'undefined') {
            App.web3Provider = web3.currentProvider;
        } else {
            App.web3Provider = new Web3.providers.HttpProvider(
                'http://localhost:8545'
            );
        }
        web3 = new Web3(App.web3Provider);

        App.displayAccountInfo();

        return App.initContract();
    },

    initContract: () => {
        $.getJSON('Rikki_Staterium.json', rikkiStateriumArtifact => {
            App.contracts.RikkiStaterium = TruffleContract(
                rikkiStateriumArtifact
            );
            App.contracts.RikkiStaterium.setProvider(App.web3Provider);
            return App.reloadGame();
        });
    },

    displayAccountInfo: () => {
        web3.eth.getCoinbase((err, account) => {
            if (err === null) {
                App.account = account;
                console.log(account);
            }
            web3.eth.getBalance(account, (err, balance) => {
                if (err === null) {
                    console.log(web3.fromWei(balance, 'ether') + ' Eth');
                }
            });
        });
    },

    reloadGame: () => {
        App.contracts.RikkiStaterium.deployed().then(instance => {
            console.log(instance);
            instance.Matches.call(11).then((match, err) => {
                console.log(match[2].toString(10));
            });
        });
    }
};
$(document).ready(() => {
    App.init();
});
