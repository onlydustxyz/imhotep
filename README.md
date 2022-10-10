<p align="center">
    <img src="resources/img/logo.png" height="200">
</p>
<div align="center">
  <h1 align="center">Imhotep</h1>
  <p align="center">
    <a href="https://discord.gg/onlydust">
        <img src="https://img.shields.io/badge/Discord-6666FF?style=for-the-badge&logo=discord&logoColor=white">
    </a>
    <a href="https://twitter.com/intent/follow?screen_name=onlydust_xyz">
        <img src="https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white">
    </a>
    <a href="https://app.onlydust.xyz/projects/523762227">
        <img src="https://img.shields.io/badge/Contribute-6A1B9A?style=for-the-badge&logo=notion&logoColor=white">
    </a>
  </p>
  
  <h3 align="center">Cairo EVM bytecode interpreter — a.k.a. the Zk-EVM</h3>
</div>

> ## ⚠️ WARNING! ⚠️
>
> This repo contains highly experimental code. Expect rapid iteration.

## 🎟️ Description

Implementing the EVM in Cairo is both a fun technical challenge and an actual
way to port Solidity smart contracts to Starknet.

We are talking here about an in-contract Ethereum bytecode interpreter. This is
not the same approach as [Warp](https://github.com/NethermindEth/warp), which is
a Solidity->Cairo transpiler.

It leads the way to more complex use cases, such as a full-fledged
EVM-compatible layer 3.

## 🎗️ Prerequisites

Install [Protostar](https://docs.swmansion.com/protostar/) version 0.4.2 or
above.

```console
curl -L https://raw.githubusercontent.com/software-mansion/protostar/master/install.sh | bash
```

## 📦 Installation

```console
protostar install
```

## 🔬 Usage

```console
protostar build
```

## 🌡️ Testing

```console
protostar test
```

## 🫶 Contributing

Please visit the [project page](https://app.onlydust.xyz/projects/523762227) on
the OnlyDust platform to find contributions.

## 📄 License

**Imhotep** is released under the [MIT](LICENSE).
