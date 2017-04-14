#--------------------------------------------------#
# 第4讲: 复杂数据处理和分析作业                    #
# Author：Datacruiser
# 知乎专栏：数海拾荒                               #
#--------------------------------------------------#

# 导入相关包
library(dplyr)
library(stringr)


#当前项目运行根路径
#例如：G:/DataCruiser/workspace/IMDB Analysis
projectPath <- getwd()
#movie_metadata.csv路径
#例如G:/DataCruiser/workspace/IMDB Analysis/data/movie_metadata.csv
servicePath <- str_c(projectPath,
                     "data",
                     "movie_metadata.csv",
                     sep = "/")

#导入数据
movies <- read.csv(servicePath, header = T, stringsAsFactors = F)

disDirector <- function(){
  #选择子集
  mymovies <- select(movies,
  					title_year,
  					imdb_score,
  					director_facebook_likes,
  					actor_1_facebook_likes)

  #列名重命名，等号左边是新列名，右边是就列名
  mymovies <- rename(mymovies, 
                     year = title_year,
                     scores = imdb_score,
                     direcotrlikes = director_facebook_likes,
                     actorlikes = actor_1_facebook_likes)
  
  #删除缺失数据
  mymovies <- filter(mymovies, 
                  !is.na(year), 
                  !is.na(scores),
                  !is.na(direcotrlikes),
                  !is.na(actorlikes))
  
  #数据排序
  mymovies <- arrange(mymovies, desc(year))
  
  #数据计算：facebook上导演点赞数与相应导演所导的电影IMDB评分数之间的关系  
  disDirector <- mymovies %>% 
    group_by(year) %>% 
    summarise(
      count = n(),
      mean_scores = mean(scores, na.rm = TRUE),
      mean_likes = mean(direcotrlikes, na.rm = TRUE)
    ) %>% 
    filter(count > 0)
  
  return(disDirector)
}


disActor <- function(){
 #选择子集
  mymovies <- select(movies,
  					title_year,
  					imdb_score,
  					director_facebook_likes,
  					actor_1_facebook_likes)

  #列名重命名，等号左边是新列名，右边是就列名
  mymovies <- rename(mymovies, 
                     year = title_year,
                     scores = imdb_score,
                     direcotrlikes = director_facebook_likes,
                     actorlikes = actor_1_facebook_likes)
  
  #删除缺失数据
  mymovies <- filter(mymovies, 
                  !is.na(year), 
                  !is.na(scores),
                  !is.na(direcotrlikes),
                  !is.na(actorlikes))
  
  #数据排序
  mymovies <- arrange(mymovies, desc(year))
  
  #数据计算：facebook上一号演员点赞数与相应导演所导的电影IMDB评分数之间的关系  
  disActor <- mymovies %>% 
    group_by(year) %>% 
    summarise(
      count = n(),
      mean_scores = mean(scores, na.rm = TRUE),
      mean_likes = mean(actorlikes, na.rm = TRUE)
    ) %>% 
    filter(count > 0)
  

  return(disActor)
}