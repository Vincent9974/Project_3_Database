#include "database.h"
#include <mysql.h>
#include <stdio.h>
#include <iostream>
#include <string>

#define DB_NAME "box_man"
#define DB_HOST "127.0.0.1"
#define DB_PORT 3306
#define DB_USER "root"
#define DB_USER_PASSWD "8956333asdf"

static int debug = 1;

static bool connect_db(MYSQL &mysql);

// 功能: 验证用户名和密码获取用户信息
// 输入: user - 用户信息结构体
// 返回值: 成功返回true,失败false.

bool fetch_user_info(userinfo &user)
{
    MYSQL mysql;
    char sql[256];
    bool ret = false;
    MYSQL_RES *res;
    MYSQL_ROW row;

    // 1. 连接到数据库
    if (connect_db(mysql) == false)
    {
        return false;
    }

    // 2.根据用户名和密码获取用户信息(id, level_id)
    snprintf(sql, 256, "select id, level_id from users where username='%s' and password=md5('%s');", user.username.c_str(), user.password.c_str());
    ret = mysql_query(&mysql, sql);

    if (ret)
    {
        printf("数据库出错,%s 错误原因: %s\n", sql, mysql_error(&mysql));
        mysql_close(&mysql);
        return false;
    }

    // 3. 返回结果
    res = mysql_store_result(&mysql);
    row = mysql_fetch_row(res);

    if (row == NULL)
    {
        mysql_free_result(res);
        mysql_close(&mysql);
        return false;
    }

    user.id = atoi(row[0]);       // id
    user.level_id = atoi(row[1]); // level_id
    printf("userid:%d, level_id:%d\n", user.id, user.level_id);

    // 4.返回结果
    // 释放结果集
    mysql_free_result(res);
    // 关闭数据库
    mysql_close(&mysql);
    return true;
}

bool connect_db(MYSQL &mysql)
{
    // 1.初始化数据库句
    mysql_init(&mysql);

    // 2. 设置字符编码
    mysql_options(&mysql, MYSQL_SET_CHARSET_NAME, "gbk");

    // 3. 连接数据库
    if (mysql_real_connect(&mysql, DB_HOST, DB_USER, DB_USER_PASSWD, DB_NAME, DB_PORT, NULL, 0) == NULL)
    {
        printf("连接失败, 错误原因:%s\n", mysql_error(&mysql));
        return false;
    }

    return true;
}

// 根据关卡id获取完整的关卡信息
bool fetch_level_info(levelinfo &level, int level_id)
{
    MYSQL mysql;
    char sql[256];
    bool ret = false;
    MYSQL_RES *res;
    MYSQL_ROW row;

    // 1. 连接到数据库
    if (connect_db(mysql) == false)
    {
        return false;
    }
    // 2.获取关卡id
    snprintf(sql, 256, "select name, map_row, map_col, map_data, next_level_id from levels where id=%d;", level_id);
    ret = mysql_query(&mysql, sql);
    if (ret)
    {
        printf("数据库出错,%s 错误原因: %s\n", sql, mysql_error(&mysql));
        mysql_close(&mysql);
        return false;
    }

    // 3获取结果
    res = mysql_store_result(&mysql);
    row = mysql_fetch_row(res);
    if (row == NULL)
    {
        mysql_free_result(res);
        mysql_close(&mysql);
        return false;
    }

    level.id = level_id;
    level.name = row[0];
    level.map_row = atoi(row[1]);
    level.map_col = atoi(row[2]);
    level.map_data = row[3];
    level.next_level_id = atoi(row[4]);
    if (debug)
    {
        printf("level id: %d  name: %s map row: %d  map column: %d map data: %s next level: %d\n", level.id, level.name.c_str(), level.map_row, level.map_col, level.map_data.c_str(), level.next_level_id);
    }
    // 释放结果集
    mysql_free_result(res);
    // 关闭数据库
    mysql_close(&mysql);
    return true;
}

bool transform_map_db2array(levelinfo &level, int map[ROW][COL])
{
    if (level.map_row > ROW || level.map_col > COL)
    {
        printf("地图超大，请重新设置!\n");
        return false;
    }

    if (level.map_data.length() < 1)
    {
        printf("地图数据有误，请重新设置!\n");
        return false;
    }

    int start = 0, end = 0;
    int row = 0, column = 0;

    do
    {
        end = level.map_data.find('|', start);

        if (end < 0)
        {
            end = level.map_data.length();
        }

        if (start >= end)
            break;

        string line = level.map_data.substr(start, end - start);
        printf("get line: %s\n", line.c_str());

        // 对行地图数据进行解析
        char *next_token = NULL;
        char *item = strtok_s((char *)line.c_str(), ",", &next_token);

        column = 0;

        while (item && column < level.map_col)
        {
            printf("%s ", item);
            map[row][column] = atoi(item);
            column++;

            item = strtok_s(NULL, ",", &next_token);
        }

        if (column < level.map_col)
        {
            printf("地图数据解析出错,终止!\n");
            return false;
        }

        printf("\n");
        row++;

        if (row >= level.map_row)
        {
            break;
        }

        start = end + 1;

    } while (1 == 1);

    if (row < level.map_row)
    {
        printf("地图行数少于设定, %d(need: %d),终止!\n", row, level.map_row);
        return false;
    }

    return true;
}

bool update_user_level(userinfo &user, int next_level_id)
{
    MYSQL mysql;
    MYSQL_RES *res; // 查询结果集
    MYSQL_ROW row;  // 记录结构体
    char sql[256];
    bool ret = false;

    // 1.连接到数据库
    if (connect_db(mysql) == false)
    {
        return false;
    }

    // 2.根据用户id 更新下一关的level_id
    snprintf(sql, 256, "update users set level_id = %d where id=%d;", next_level_id, user.id);

    ret = mysql_query(&mysql, sql);

    if (ret)
    {
        printf("数据库更新出错，%s 错误原因： %s\n", sql, mysql_error(&mysql));
        mysql_close(&mysql);
        return false;
    }

    mysql_close(&mysql);
    return true;
}