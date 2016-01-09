# ReactNative简单使用
title: ReactNative简单使用
tags : [IOS开发SDK]
date: 2015-10-15 11:50:07
---

**介绍**
http://www.linuxidc.com/Linux/2015-09/123239.htm

**React**
http://baike.baidu.com/link?url=sgXYXYrN7O5-Wbdfx1kMyqAno2vr7bVobWp7A_stqJ9YZOCrDcfwlnuCcoqg9GSHs7nbfJ2NIpqQGx0O2SZvBsqzP4MkzFVNN7SSMZQLT4BZYM-0jHJ4jmwVsDP8YHQX1Ob0A02bKgi2l8niGT_rYRgQVzXrbm4k4WjJPSvt5GcP8IbvS3ESvPngt7o51n_9a6xAFL2q1zzNNK1q5L-L8ZyWKUWRUj0MQi0iwqxvQyi

http://www.ruanyifeng.com/blog/2015/03/react.html
**JSX**
http://reactjs.cn/react/docs/jsx-in-depth.html
**flex-css**
http://www.tuicool.com/articles/a6Rjmi2
http://www.cocoachina.com/ios/20150420/11608.html

**React Native For Android 架构初探**
http://mp.weixin.qq.com/s?__biz=MzI1MTA1MzM2Nw==&mid=207782506&idx=1&sn=3ff6b03c0d59fbda406f64739d9272cf&scene=1&srcid=1009Q3qo6mLeT2ydjdzUwLQ7&from=groupmessage&isappinstalled=0#rd


**整理了一份React-Native学习指南**
http://www.tuicool.com/articles/zaInUbA

**工具**
http://www.cocoachina.com/ios/20150327/11439.html
https://github.com/facebook/nuclide

**例子说明**
参考文档
http://wiki.jikexueyuan.com/project/react-native/GettingStarted.html

![工程结构](/MyImage/ReactNative/ReactNativeProjectBase.png)


    'use strict';
    /**
     * Sample React Native App
     * https://github.com/facebook/react-native
     */
    'use strict';

    var React = require('react-native');
    var NSUITableViewController = require('./NSUITableViewController'); //引入其他模块
    var NSUINavigationController = require('./NSUINavigationController');
    var REQUEST_URL = 'https://raw.githubusercontent.com/facebook/react-native/master/docs/MoviesExample.json';
    var {
     AppRegistry,
     Image,
     StyleSheet,
     Text,
     View,
     ListView,
     NavigatorIOS,   //注册导航控件
     TabBarIOS,      //注册tarbar控件
    } = React;

    var PropertyFinder = React.createClass({
    
    getInitialState: function() {
    return {
      dataSource: new ListView.DataSource({
        rowHasChanged: (row1, row2) => row1 !== row2,
      }),
      loaded: false,
    };
     },   //设置状态
     
      componentDidMount: function() {
        this.fetchData();
     },   //componentDidMount 是 React 组件里面只会调用一次的函数。
     
     fetchData: function() {
      fetch(REQUEST_URL)
       .then((response) => response.json())
          .then((responseData) => {
          this.setState({
             dataSource: this.state.dataSource.cloneWithRows(responseData.movies),
              loaded: true,
          });
       })
          .done();
     },   //获取数据
 
      render: function()  {   //渲染函数

        return (
          <TabBarIOS>
            <TabBarIOS.Item title="React Native" 
            selected={this.state.selectedTab === 'blueTab'} 
            icon={require('./flux.png')}
            onPress={() => {
                               this.setState({
                               selectedTab: 'blueTab',
                                       });
                                }}
            >
             <NavigatorIOS
            style={{flex : 1,backgroundColor: '#000000'}}
            tintColor='#cccccc'
            barTintColor='#ccffcc'
            initialRoute={{
              title: 'blueTab',
              component: NSUITableViewController,
            }}/>
            </TabBarIOS.Item>
                 <TabBarIOS.Item title="React Native" 
                  selected={this.state.selectedTab === 'redTab'} 
                  icon={require('./flux.png')}
                        onPress={() => {
                               this.setState({
                               selectedTab: 'redTab',
                                       });
                                }}
                 >
             <NavigatorIOS
            style={{flex : 1,backgroundColor: '#000000'}}
            tintColor='#cccccc'
            barTintColor='#c00cccc'
            initialRoute={{
              title: 'redTab',
              component: NSUITableViewController,
            }}/>
            </TabBarIOS.Item>
                     <TabBarIOS.Item title="React Native" 
                  selected={this.state.selectedTab === 'greenTab'} 
                  icon={require('./flux.png')}
                        onPress={() => {
                               this.setState({
                               selectedTab: 'greenTab',
                                       });
                                }}
                 >
             <NavigatorIOS
            style={{flex : 1,backgroundColor: '#000000'}}
            tintColor='#cccccc'
            barTintColor='#ccccff'
            initialRoute={{
              title: 'greenTab',
              component: NSUITableViewController,
            }}/>
            </TabBarIOS.Item>
          </TabBarIOS>
      
        );   
    },

    _renderContent: function(color: string, pageText: string, num?: number) {
    return (
      <View style={[styles.tabContent, {backgroundColor: color}]}>
        <Text style={styles.tabText}>{pageText}</Text>
        <Text style={styles.tabText}>{num} re-renders of the {pageText}</Text>
      </View>
    );
      },
      renderLoadingView: function() {
    return (
      <View style={styles.container}>
        <Text>
          Loading movies...
        </Text>
      </View>
    );
      },

      renderMovie: function(movie) {
    return (
      <View style={styles.container}>
        <Image
          source={{uri: movie.posters.thumbnail}}
          style={styles.thumbnail}
        />
        <View style={styles.rightContainer}>
          <Text style={styles.title}>{movie.title}</Text>
          <Text style={styles.year}>{movie.year}</Text>
        </View>
      </View>
    );
      },
    });

    var Style = StyleSheet.create({
      container: {
      flex: 1,
      backgroundColor: '#F5FCFF'
     },
      navigator: {
      backgroundColor: '#EFEFEF'
     }
    });

    var styles = StyleSheet.create({
     container: {
       flex: 1,
       flexDirection: 'row',
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: '#F5FCFF',
      },
      rightContainer: {
        flex: 1,
      },
     title: {
       fontSize: 20,
       marginBottom: 8,
       textAlign: 'center',
     },
     year: {
       textAlign: 'center',
      },
      welcome: {
       fontSize: 20,
       textAlign: 'center',
       margin: 10,
     },
    instructions: {
       textAlign: 'center',
        color: '#333333',
        marginBottom: 5,
      },
     thumbnail: {
       width: 53,
       height: 81,
      },
     listView: {
       paddingTop: 20,
       backgroundColor: '#F5FCFF',
    },
    });

    AppRegistry.registerComponent('PropertyFinder', () => PropertyFinder);








