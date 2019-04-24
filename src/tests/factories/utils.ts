import * as faker from "faker";
import { ModelClassGetter } from "sequelize-typescript/lib/types/ModelClassGetter";

export namespace FactoryUtils {
  export function randomGeo(center, radius): { lat: number, lng: number } {
    const y0 = +center.lat;
    const x0 = +center.lng;
    const rd = radius / 111300;

    const u = Math.random();
    const v = Math.random();

    const w = rd * Math.sqrt(u);
    const t = 2 * Math.PI * v;
    const x = w * Math.cos(t);
    const y = w * Math.sin(t);

    return {
      lat: y + y0,
      lng: x + x0
    };
  }

  export async function getRandomId(modelGetter: ModelClassGetter, assoc?: any): Promise<number> {
    const model = modelGetter.bind(modelGetter())();
    const $instance = await model.findOne({ order: [model.sequelize.fn("random")] });
    return $instance ? $instance.id : assoc;
  }

  export function getRandomPhoneNumber() {
    let phonePnumber = "+380";

    for (let i = 0; i < 9; i++) {
      phonePnumber = `${phonePnumber}${faker.random.number({ min: 0, max: 9 })}`;
    }

    return phonePnumber;
  }

  export function getRandomZipCode() {
    let zipCode = "";

    for (let i = 0; i < 5; i++) {
      zipCode = `${zipCode}${faker.random.number({ min: 0, max: 9 })}`;
    }

    return zipCode;
  }

  getBank.current = null;

  export function getBank(id) {
    const banks = {
      1: {
        name: 'PrivatBank',
        transitAccount: '4567344295080587253409579508',
        bic: 'GB29NWBK60161331926825',
        bin: 'GB29NWBK601613736474'
      },
      2: {
        name: 'OTPBank',
        transitAccount: '8567344295080587253409579508',
        bic: 'CH9300762011623852957',
        bin: 'CH930076201162385239484'
      },
      3: {
        name: 'InvestBank',
        transitAccount: '0987344295080587253409579508',
        bic: 'NL91ABNA0417164299',
        bin: 'NL91ABNA0417164893748'
      },
      4: {
        name: 'BNP',
        transitAccount: '2916344295080587253409579508',
        bic: 'HU42117730161111101800000000',
        bin: 'HU42117730161111101883758375'
      }
    }

    getBank.current = banks[id];

    return banks[id].name;
  }

  dateGenerator.dayNumber = 1;
  export function dateGenerator(options?) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'July', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];
    const years = [2016, 2017, 2018];

    const day = faker.random.number({
      min: 1,
      max: 28
    });

    const month = (options && options.month) ? months[options.month] : faker.random.arrayElement(months);
    const year = (options && options.year) ? options.year : faker.random.arrayElement(years);
    const hour = (options && options.hour) ? options.hour : faker.random.number({
      min: 1,
      max: 20
    });

    const date = new Date(`${day} ${month} ${year} ${hour}:30:00 GMT+00:00`);
    dateGenerator.dayNumber = day;
    return date;
  }

}
