const fs = require('fs');
const readline = require('readline');
const TestCaseBuilder = require('./testCaseBuilder');

module.exports = class Export {
  static relativeTestResultsPath = '../tests_result/';

  constructor(reportSource, exportFunction = async (x) => { console.log(JSON.stringify(x)); }) {
    this.export = exportFunction;
    this.dataSource = reportSource;
  }

  async exportData() {
    const dataToExport = new TestCaseBuilder(await this.loadData()).buildExecutionResult();
    await this.export(dataToExport).catch((err) => console.log(err));
  }

  async loadData() {
    const fileStream = fs.createReadStream(this.dataSource);
    const rl = readline.createInterface({
      input: fileStream,
      crlfDelay: Infinity,
    });

    const items = [];
    // eslint-disable-next-line no-restricted-syntax
    for await (const line of rl) {
      try {
        const searchTerm = '{';
        const indexOfFirst = line.indexOf(searchTerm);
        // Message format sometimes have artefacts at start of line
        const fixedLine = line.substring(indexOfFirst);
        items.push(JSON.parse(fixedLine));
      } catch (e) {
        console.error(e);
      }
    }
    return items;
  }
};
