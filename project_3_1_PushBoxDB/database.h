#pragma once

#include <string>
using namespace std;
#define ROW 48
#define COL 48

// 用户信息
typedef struct _userinfo
{
    int id;
    string username; // 用户名
    string password; // 密码
    int level_id;    // 关卡id
} userinfo;

typedef struct _levelinfo
{
    int id;
    string name;
    int map_row;
    int map_col;
    string map_data;
    int next_level_id;
} levelinfo;

bool fetch_level_info(levelinfo &level, int level_id);
bool fetch_user_info(userinfo &user);
bool transform_map_db2array(levelinfo& level, int map[ROW][COL]);
bool update_user_level(userinfo& user, int next_level_id);