import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("ERC20", (m) => {
  const ERC20Contract = m.contract("ERC20", ["TokenCodeX", "TCX"]);
  return { ERC20Contract };
});