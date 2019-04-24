const options = {
  menu: [
    {
      group: "Appetizers",
      foods: [
        {
          name: "Triple Dipper",
          price: 1
        },
        {
          name: "Boneless Wings",
          price: 2
        },
        {
          name: "Bone-in Wings",
          price: 1
        },
        {
          name: "Classic Nachos",
          price: 1.5
        },
        {
          name: "Crispy Cheddar Bites",
          price: 1.7
        }
      ]
    },
    {
      group: "Ribs & Steaks",
      foods: [
        {
          name: "Mix & Match Ribs",
          price: 0.7
        },
        {
          name: "Classic Sirloin* - 6oz",
          price: 1.2
        },
        {
          name: "Honey-Chipotle Half Order Ribs",
          price: 5
        },
        {
          name: "Classic Ribeye*",
          price: 3.6
        },
        {
          name: "Classic Sirloin* - 10oz",
          price: 2.3
        }
      ]
    },
    {
      group: "Kids Menu",
      foods: [
        {
          name: "Pepperoni Pizza",
          price: 1
        },
        {
          name: "Cheesy Chicken Pasta",
          price: 2
        },
        {
          name: "Grilled Chicken Dippers",
          price: 1
        },
        {
          name: "Burger Bites",
          price: 0.5
        },
        {
          name: "Macaroni & Cheese",
          price: 1.5
        }
      ]
    },
    {
      group: "Desserts",
      foods: [
        {
          name: "Molten Chocolate Cake",
          price: 5
        },
        {
          name: "Skillet Chocolate Chip Cookie",
          price: 3
        },
        {
          name: "Cheesecake",
          price: 2.7
        },
        {
          name: "Paradise Pie",
          price: 7.7
        },
        {
          name: "Napoleon",
          price: 2.3
        }
      ]
    },
    {
      group: "Big Mouth Burgers",
      foods: [
        {
          name: "The Boss Burger",
          price: 3
        },
        {
          name: "Mushroom Swiss Burger",
          price: 4
        },
        {
          name: "Queso Burger",
          price: 5
        },
        {
          name: "Chili's Chili Burger",
          price: 2
        },
        {
          name: "Oldtimer",
          price: 8
        }
      ]
    },
    {
      group: "Drinks",
      foods: [
        {
          name: "Coca",
          price: 1
        },
        {
          name: "Juice",
          price: 1
        },
        {
          name: "Water",
          price: 0.5
        },
        {
          name: "Tea",
          price: 0.7
        },
        {
          name: "Coffee",
          price: 1
        }
      ]
    }
  ],
  stock: [
    {
      group: 'Fish',
      products: [
        {
          name: 'Catfish',
          code: 'prd1-ct11',
          price: 3
        },
        {
          name: 'Salmon',
          code: 'prd2-ct11',
          price: 3
        },
        {
          name: 'Crucian carp',
          code: 'prd3-ct11',
          price: 3
        },
        {
          name: 'Red caviar',
          code: 'prd4-ct11',
          price: 2
        },
        {
          name: 'Black caviar',
          code: 'prd5-ct11',
          price: 5
        }
      ]
    },
    {
      group: 'Meat',
      products: [
        {
          name: 'Beef steaks',
          code: 'prd6-ct22',
          price: 3
        },
        {
          name: 'Pork steaks',
          code: 'prd7-ct22',
          price: 3
        },
        {
          name: 'Pig legs',
          code: 'prd8-ct22',
          price: 3
        },
        {
          name: 'Beef legs',
          code: 'prd9-ct22',
          price: 2
        }
      ]
    },
    {
      group: 'Fruit',
      products: [
        {
          name: 'Orange',
          code: 'prd10-ct11',
          price: 3
        },
        {
          name: 'Tangerine',
          code: 'prd11-ct11',
          price: 3
        },
        {
          name: 'Apple',
          code: 'prd12-ct11',
          price: 3
        },
        {
          name: 'Banana',
          code: 'prd13-ct11',
          price: 2
        },
        {
          name: 'Cherry',
          code: 'prd14-ct11',
          price: 2
        }
      ]
    },
    {
      group: 'Vegetable',
      products: [
        {
          name: 'Potato',
          code: 'prd15-ct11',
          price: 3
        },
        {
          name: 'Cucumber',
          code: 'prd16-ct22',
          price: 3
        },
        {
          name: 'Cherry tomato',
          code: 'prd17-ct22',
          price: 3
        },
        {
          name: 'Tomato',
          code: 'prd18-ct22',
          price: 2
        },
        {
          name: 'Korean cabbage',
          code: 'prd19-ct22',
          price: 2
        },
        {
          name: 'White cabbage',
          code: 'prd20-ct22',
          price: 2
        }
      ]
    }
  ],
  countOptions: {
    users: {
      employees: 10,
      clients: 100000
    },
    discounts: {
      groups: ['Daily', 'Accumulative']
    }
  },
  banks: [
    {
      name: 'PrivatBank',
      transitAccount: '4567344295080587253409579508',
      bic: 'GB29NWBK60161331926825',
      bin: 'GB29NWBK601613736474'
    },
    {
      name: 'OTPBank',
      transitAccount: '8567344295080587253409579508',
      bic: 'CH9300762011623852957',
      bin: 'CH930076201162385239484'
    },
    {
      name: 'InvestBank',
      transitAccount: '0987344295080587253409579508',
      bic: 'NL91ABNA0417164299',
      bin: 'NL91ABNA0417164893748'
    },
    {
      name: 'BNP',
      transitAccount: '2916344295080587253409579508',
      bic: 'HU42117730161111101800000000',
      bin: 'HU42117730161111101883758375'
    }
  ],
  employeeRoles: [
    {
      name: 'Manager',
      desc: 'Responsible for service and personal, stock and orders',
      count: 2
    },
    {
      name: 'Waiter',
      desc: 'Responsible for client',
      count: 5
    },
    {
      name: 'Accountant',
      desc: 'Responsible for accounts and payslips',
      count: 3
    }
  ],
  productOrderStatuses: [
    {
      name: 'Created'
    },
    {
      name: 'In-Process'
    },
    {
      name: 'Delivered'
    }
  ],
  transactionStatuses: [
    {
      name: 'Created',
      desc: 'When transaction is only created but not in process'
    },
    {
      name: 'Canceled',
      desc: 'When transaction is canceled'
    },
    {
      name: 'In-Process',
      desc: 'When transaction in process already'
    },
    {
      name: 'Success',
      desc: 'When transaction is successfull'
    }
  ],
  transactionTypes: [
    {
      name: 'Salary',
      desc: 'Pay salary'
    },
    {
      name: 'Order-Food',
      desc: 'Food orders'
    },
    {
      name: 'Earnings',
      desc: 'Earnings from service'
    }
  ]
};

export default options;
