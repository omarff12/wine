import React, { useState, useEffect } from 'react';
import Web3 from 'web3';
import { stakingContract, nftContract, governanceContract } from './utils/contractUtils';

const Dashboard = () => {
    const [account, setAccount] = useState('');
    const [stakingBalance, setStakingBalance] = useState(0);
    const [nftBalance, setNftBalance] = useState(0);

    useEffect(() => {
        const loadWeb3 = async () => {
            const web3 = new Web3(window.ethereum);
            await window.ethereum.enable();
            const accounts = await web3.eth.getAccounts();
            setAccount(accounts[0]);
        };

        const loadStakingData = async () => {
            const balance = await stakingContract.methods.stakes(account).call();
            setStakingBalance(balance);
        };

        const loadNFTData = async () => {
            const balance = await nftContract.methods.balanceOf(account).call();
            setNftBalance(balance);
        };

        loadWeb3();
        loadStakingData();
        loadNFTData();
    }, [account]);

    return (
        <div>
            <h1>Welcome to CryptoVerse, {account}</h1>
            <h2>Staking Balance: {stakingBalance}</h2>
            <h2>NFT Balance: {nftBalance}</h2>
        </div>
    );
};

export default Dashboard;
