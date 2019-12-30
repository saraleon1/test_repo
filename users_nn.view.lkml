view: users_nn {
  sql_table_name: demo_db.usersNN ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

#  One dimension of each of the following types
#  x Number, x case,  x string, x tier, x zipcode (in users explore), x yesno
#  One measure of each of the following types
#  Min, max, average, sum, sum_distinct

dimension: testnum {
  type:  number
  sql:  ${TABLE}.id ;;
}

  dimension: testyesno {
    type: yesno
    sql: ${TABLE}.last_name LIKE '%B%' ;;
  }

dimension: testcase {
  case: {
    when: {
      sql: ${TABLE}.last_name LIKE '%A%';;
      label: "Label of Condition"
    }
    # possibly more when statements
    else: "Label If No Condition Met"
  }
}

  dimension: teststring {
    type:  string
    sql:  ${TABLE}.last_name ;;
  }

  dimension: testtier {
    type:  tier
    tiers: [0,10,20,30,40,50,60]
    style: integer
    sql: ${id} ;;
  }


# Min, max, average, sum, sum_distinct


  measure: count {
    type: count
    drill_fields: [id, first_name, last_name]
  }

  measure: min {
    type: min
    drill_fields: [id, testnum]
  }

  measure: max {
    type: max
    drill_fields: [id, testnum]
  }

  measure: avg {
    type: average
    drill_fields: [id, testnum]
  }

  measure: sum {
    type: sum
    drill_fields: [id, testnum]
  }

  measure: sum_dist {
    type: sum_distinct
    drill_fields: [id, testnum]
  }
  measure: testmeasure {
    type: count

    filters: {
      field: last_name
      value: "cancelled"
    }
    filters: {
      field: first_name
      value: "last week"
    }
  }
}
