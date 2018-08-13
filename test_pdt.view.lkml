view: customer_order_facts {
  derived_table: {
    sql:
      SELECT
        order_items.id,
        MIN(DATE(order_items.created_at)) AS first_order_date,
        SUM(order_items.sale_price) AS lifetime_amount
      FROM
        order
      GROUP BY
        order_id ;;
  }
  dimension: user_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.user_id ;;
  }
  dimension_group: first_order {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.first_order_date ;;
  }
  dimension: lifetime_amount {
    type: number
    value_format: "0.00"
    sql: ${TABLE}.lifetime_amount ;;
  }
}
