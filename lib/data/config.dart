// const BASE_URL = "http://172.105.24.23/api";
const BASE_URL = "https://mflip.com/api";
//const BASE_URL = "http://southwind.app/";
//////////// api End////////////////
/// AUTH ///
const api_loginApiEnd = "/login";
const api_getUserData = "/user";
const api_libraryDataEnd = "/get_resource_library";
const api_resetToken = '/reset_push_token';
const api_forgetPassword = '/forgot_password';
// team
const api_teamdetail = '/get_teamlist';

/// News ///
const api_getNews = "/get_comm_notification";
// const api_newsLike = '/set_notification_like';
// const api_newsDislike = '/set_notification_unlike';
const api_communication_get_notification = "/communication-notification/list";
const api_communication_like = "/communication-notification/like";
const api_communication_unlike = '/communication-notification/unlike';
const   api_communication_comment = '/communication-notification/comment-add';

const apiCommentList = "/communication-notification/comments";
// const api_communcation_unlike = ""
// Incentive
const api_mostPopularIncentive = "/most_popular_incentives_list";
const api_IncentiveHistory = '/new_incentive_details';
const api_IncentiveEarned = '/badges_earned_list';
const api_newIncentive = '/get_incentive_list_new';
const api_usedIncentive = '/new_used_incentive_details';
// timer card
const api_timerHistory = '/get_timecard_history_2021';
const api_timerHistoryDate = '/get_timecard_history_2021_dates';
const api_punchInAndOut = '/timecard';
// carrer
const api_career = '/career-path/list';
// const api_career = '/career-path/get-career-path-by-team';
const api_career_submit_answer = "/career-path/submit-answer";
const api_career_single_career =
    '/career-path/career-path-by-id?career_path_id=';
//survey
const api_getSurvey = '/get_new_survey';
const api_getSurveyNotification = '/survey-notification/list?limit=20&offset=0';
const api_getIndividualSurvey =
    '/survey-notification/notification-by-id?notification_id=';
const api_submitSurveyAnswer = '/survey-notification/submit-answer';
// leaderboard
const api_leader_board_all_new = '/get_leader_board_all_new';
const api_teamLeader = '/get_leader_board_new';
// schedule
const api_schedule = '/get_profile_schedule';
const api_set_time_off_request = '/set_time_off_request';
// learning
const api_learning_get = '/learning-notification/list?limit=20&offset=0';
const api_getIndividual_learning =
    '/learning-notification/notification-by-id?notification_id=';
const api_learning_submit_answer = "/learning-notification/submit-answer";
// group
const api_group_list = '/get_groups';
const api_get_group_msgs = '/get_group_msgs';
const api_getGroup_participates = '/get_group_members';
const api_sendMessage = '/set_group_msgs';
// jobs
const api_addPost = '/jobs/add';
const int offsetDifference = 20;
const api_teamMember = "/team_members";
const api_todaysJob = "/jobs";

/// feedback
const api_getFeedBack = "/career-path/get-feedback";
