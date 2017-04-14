#--------------------------------------------------#
# 第4讲: 复杂数据处理和分析作业                    #
# Author：Datacruiser
# 知乎专栏：数海拾荒                               #
#--------------------------------------------------#


#视图模块

library(ggplot2)
library(stringr)

#当前项目运行根路径
#例如：C:/install/workspace/da
projectPath <- getwd()
#service路径
#例如C:/install/workspace/da/service/flight.R
servicePath <- str_c(projectPath,
                     "service",
                     "movie.R",
                     sep="/")

#编译R文件
source(servicePath)

disDirector <- disDirector()
disActor <- disActor()

#导演评分散点图
directorView <- ggplot(data = disDirector) + 
  geom_point(mapping = aes(x = mean_likes, y = mean_scores))+
  geom_smooth(mapping = aes(x = mean_likes, y = mean_scores))

#保存分析结果
outputpath <- str_c(projectPath,"output","movieScore vs direcetorLikes.jpg",sep="/")

ggsave(filename=outputpath, plot=directorView)


#演员评分散点图
actorView <- ggplot(data = disActor) + 
  geom_point(mapping = aes(x = mean_likes, y = mean_scores))+
  geom_smooth(mapping = aes(x = mean_likes, y = mean_scores))

#保存分析结果
outputpath <- str_c(projectPath,"output","movieScore vs actorLikes.jpg",sep="/")

ggsave(filename=outputpath, plot=actorView)



