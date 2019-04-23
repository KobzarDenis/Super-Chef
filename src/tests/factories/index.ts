import * as fs from "fs-extra";
import * as path from "path";
import factory from "./factory";

const currentPath = path.join(__dirname, "./");

const files = fs.readdirSync(currentPath);

for (const file of files) {
  if ((path.extname(file) !== ".js" && path.extname(file) !== ".ts") || file.indexOf(".factory") === -1) {
    continue;
  }
  require(path.join(currentPath, file));
}

export * from "./utils";
export default factory;
