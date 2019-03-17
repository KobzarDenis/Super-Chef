with codes as (
  select SUBSTRING(DST_NUMBER_BILL, 1, 1) as code, DST_NUMBER_BILL from (select DISTINCT(DST_NUMBER_BILL) from CDR) as c
  UNION
  select SUBSTRING(DST_NUMBER_BILL, 1, 2) as code, DST_NUMBER_BILL from (select DISTINCT(DST_NUMBER_BILL) from CDR) as c
  UNION
  select SUBSTRING(DST_NUMBER_BILL, 1, 3) as code, DST_NUMBER_BILL from (select DISTINCT(DST_NUMBER_BILL) from CDR) as c
  UNION
  select SUBSTRING(DST_NUMBER_BILL, 1, 4) as code, DST_NUMBER_BILL from (select DISTINCT(DST_NUMBER_BILL) from CDR) as c
  UNION
  select SUBSTRING(DST_NUMBER_BILL, 1, 5) as code, DST_NUMBER_BILL from (select DISTINCT(DST_NUMBER_BILL) from CDR) as c
  UNION
  select SUBSTRING(DST_NUMBER_BILL, 1, 6) as code, DST_NUMBER_BILL from (select DISTINCT(DST_NUMBER_BILL) from CDR) as c
  UNION
  select SUBSTRING(DST_NUMBER_BILL, 1, 7) as code, DST_NUMBER_BILL from (select DISTINCT(DST_NUMBER_BILL) from CDR) as c
  UNION
  select SUBSTRING(DST_NUMBER_BILL, 1, 8) as code, DST_NUMBER_BILL from (select DISTINCT(DST_NUMBER_BILL) from CDR) as c
  UNION
  select SUBSTRING(DST_NUMBER_BILL, 1, 9) as code, DST_NUMBER_BILL from (select DISTINCT(DST_NUMBER_BILL) from CDR) as c
)
select DST_NUMBER_BILL, BILL_DATE, BILL_TIME, rate_t * elapsed_time / 60 as price
from
  (
    select
      DST_NUMBER_IN,
      c.DST_NUMBER_BILL,
      SRC_IP,
      ip_o.OP_ID as site_o,
      s_o.SITENAME as sname_o,
      DST_IP,
      ip_t.OP_ID as site_t,
      s_t.SITENAME as sname_t,
      r_t.PRICE as rate_t,
      r_o.PRICE as rate_o,
      d_t.CODE as CODE_t,
      d_o.CODE as CODE_o,
      BILL_DATE,
      BILL_TIME,
      ELAPSED_TIME,
      row_number() over (partition by dst_number_bill, bill_date, bill_time order by length(c1.code) desc) as rn_c1,
      row_number() over (partition by dst_number_bill, bill_date, bill_time order by length(c2.code) desc) as rn_c2
    from
      CDR as c
        INNER JOIN oper_ip_tmp ip_o on ip_o.IP_OP = c.SRC_IP
        INNER JOIN oper_ip_tmp ip_t on ip_t.IP_OP = c.DST_IP
        INNER JOIN SITE as s_t ON s_t.ID = ip_t.OP_ID
        INNER JOIN SITE as s_o ON s_o.ID = ip_o.OP_ID
        INNER JOIN RATES as r_t ON r_t.RATE_ID = s_t.rate_t AND c.BILL_DATE BETWEEN r_t.RATE_DATE AND r_t.STOP_DATE
        INNER JOIN RATES as r_o ON r_o.RATE_ID = s_o.rate_o AND c.BILL_DATE BETWEEN r_o.RATE_DATE AND r_o.STOP_DATE
        INNER JOIN DEST_CODE d_t on d_t.DEST_ID=r_t.CODE_ID
        INNER JOIN DEST_CODE d_o on d_o.DEST_ID=r_o.CODE_ID
        inner join codes as c1 on c.DST_NUMBER_BILL=c1.DST_NUMBER_BILL and d_t.CODE=c1.code
        inner join codes as c2 on c.DST_NUMBER_BILL=c2.DST_NUMBER_BILL and d_o.CODE=c2.code
  ) s1
where rn_c1 = 1 and rn_c2 = 1