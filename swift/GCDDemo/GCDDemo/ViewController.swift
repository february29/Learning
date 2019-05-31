//
//  ViewController.swift
//  GCDDemo
//
//  Created by bai on 2019/5/31.
//  Copyright © 2019 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //主队列
//        let mainQueue = DispatchQueue.main;
        //全局并发队列
//        let globleQueue = DispatchQueue.global(qos: .default);
        //创建队列
//        DispatchQueue(label: "com.xianzhi.www", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: <#T##DispatchQueue?#>)
        
//        ms();
//        ma();

//        ss();
//        sa();

//        cs()
//        ca()
        
        let btn = UIButton();
        btn.frame = CGRect(x: self.view.frame.size.width/2 - 100, y: 100, width: 200, height: 40);
        btn.setTitle("start procut", for: .normal);
        btn.backgroundColor = UIColor.green;
        btn.addTarget(self, action: #selector(startProduct), for: .touchUpInside)
        self.view.addSubview(btn);
        
        let btn2 = UIButton();
        btn2.frame = CGRect(x: self.view.frame.size.width/2 - 100, y: 200, width: 200, height: 40);
        btn2.setTitle("stop procut", for: .normal);
        btn2.backgroundColor = UIColor.green;
        btn2.addTarget(self, action: #selector(endProduct), for: .touchUpInside)
        self.view.addSubview(btn2);
        
        let btn3 = UIButton();
        btn3.frame = CGRect(x: self.view.frame.size.width/2 - 100, y: 300, width: 200, height: 40);
        btn3.setTitle("start custom", for: .normal);
        btn3.backgroundColor = UIColor.green;
        btn3.addTarget(self, action: #selector(startCustom), for: .touchUpInside)
        self.view.addSubview(btn3);
        
        let btn4 = UIButton();
        btn4.frame = CGRect(x: self.view.frame.size.width/2 - 100, y: 400, width: 200, height: 40);
        btn4.setTitle("stop custom", for: .normal);
        btn4.backgroundColor = UIColor.green;
        btn4.addTarget(self, action: #selector(endCustom), for: .touchUpInside)
        self.view.addSubview(btn4);
        
    }
    
    //    主队列 + 同步 ：
    //死锁 导致崩溃 串行执行需要一个完成后执行下一个    主队里中存在mss函数的任务0，主队里添加任务一，因为串行 任务一需要等任务0完成  任务0又需任务一完成后才能完成。
    func ms()  {
        
        print("start")
        let queue =  DispatchQueue.main;
        //        let queue = DispatchQueue(label: "com.xianzhi.css", qos: .default, attributes: .initiallyInactive)
        
        //sync不具备开启线程的能力 所以都在当前线程主线程执行
        queue.sync {
            
            print("任务一 -- \(Thread.current)")
            
            
        }
        queue.sync {
            Thread.sleep(forTimeInterval: 3);
            print("任务二 -- \(Thread.current)")
        }
        queue.sync {
            print("任务三 -- \(Thread.current)")
        }
        
        print("end")
    }
    
    //    主队列 + 异步 ： 将任务追加到主队列，当主队列中的其他任务执行完之后才会执行，并且在在主线程中执行。
    func ma()  {
        
        print("start")
        let queue =  DispatchQueue.main;

        queue.async {
            print("任务一 -- \(Thread.current)")
            
        }
        queue.async {
            Thread.sleep(forTimeInterval: 3);
            print("任务二 -- \(Thread.current)")
        }
        queue.async {
            print("任务三 -- \(Thread.current)")
        }
        
        print("end")
        
        // start end  123
        
        
    }
    
    //    串行队列（非主队列） + 同步 :
    //不具备开辟新线程的能力  都在主线程中执行 新的串行队列也在主线程中
    func ss()  {
        print("start")
//        let queue =  DispatchQueue.main;
        let queue = DispatchQueue(label: "com.xianzhi.sss")
        queue.sync {
            print("任务一 -- \(Thread.current)")
            
        }
        queue.sync {
            Thread.sleep(forTimeInterval: 3);
            print("任务二 -- \(Thread.current)")
        }
        queue.sync {
            print("任务三 -- \(Thread.current)")
        }
        
        print("end")
        
        //start 123 end
    }
    
    
   
    //    串行队列（非主队列） + 异步 : 队列中的任务在新线程中依次执行。
    func sa()  {
        
        print("start")
        //        let queue =  DispatchQueue.main;
        let queue = DispatchQueue(label: "com.xianzhi.sss")

        queue.async {
            print("任务一 -- \(Thread.current)")
            
        }
        queue.async {
            Thread.sleep(forTimeInterval: 3);
            print("任务二 -- \(Thread.current)")
        }
        queue.async {
            print("任务三 -- \(Thread.current)")
        }
        
        print("end")
        
        // start end 123
    }

    //并发队列 + 同步 : 队列中的任务在当前线程中依次执行。
    
    //sync不具备开启线程的能力 所以都在当前线程主线程执行
    func cs()  {
        
        
        print("start")
        let queue = DispatchQueue(label: "com.xianzhi.css", qos: .default, attributes: .concurrent)
        
        //sync不具备开启线程的能力 所以都在当前线程主线程执行
        queue.sync {
            
             print("任务一 -- \(Thread.current)")
        
           
        }
        queue.sync {
             Thread.sleep(forTimeInterval: 3);
            print("任务二 -- \(Thread.current)")
        }
        queue.sync {
            print("任务三 -- \(Thread.current)")
        }
        
        print("end")
        
        // start 123 end  顺序执行 都是在当前线程执行 没有开启新线程
        
    }
    //    并发队列 + 异步 : 队列中的任务在新线程中并发执行。
    func ca()  {
        print("start")
        let queue = DispatchQueue(label: "com.xianzhi.css", qos: .default, attributes: .concurrent)
        queue.async {
            
            print("任务一 -- \(Thread.current)")
            
        }
        queue.async {
            
            Thread.sleep(forTimeInterval: 3);
            print("任务二 -- \(Thread.current)")
        }
        queue.async {
           
            print("任务三 -- \(Thread.current)")
        }
        
        print("end")
        
    //         start end 任务一 任务三 任务二 开启新线程，切任务一二三互不影响
    }
    


    //asyncAfter
    func asyncAfter(){
        //异步延迟 不阻塞当前任务队列
        DispatchQueue.main.asyncAfter(wallDeadline: DispatchWallTime.now()+3) {
            print("延迟执行任务")
        }
    }
    
    //在追加到DispatchQueue中的多个处理全部结束后想执行结束处理，这个时候就可用到DispatchGroup
    func dispatchGroup()  {
        let group = DispatchGroup()
        let queue = DispatchQueue.global()
        queue.async(group: group) {
            print("任务一")
        }
        queue.async(group: group) {
            print("任务二")
        }
        queue.async(group: group) {
            print("任务三")
        }
        group.notify(queue: DispatchQueue.main) {
            print("完成任务一、二、三")
        }
        queue.async {
            print("任务四")
        }
        
        //结果 完成任务一、二、三 最后执行  其他随机
    }
    
    
    //DispatchWorkItem可以将任务封装成DispatchWorkItem对象。
    
    func dispatchWorkItem()  {
        let workItem = DispatchWorkItem.init {
            print("任务一")
        }
        
        let workItem2 = DispatchWorkItem.init {
            print("任务二")
        }
        
        let group = DispatchGroup()
        let queue = DispatchQueue.global()
       
        queue.async(group: group, execute: workItem)
        queue.async(group: group, execute: workItem2)
        
        
        
        
        
    }
    //concurrentPerform会按指定次数异步执行任务，并且会等待指定次数的任务全部执行完成，即会阻塞线程。建议在子线程中使用。
    
    func concurrentPerform()  {
        DispatchQueue.global().async {
            DispatchQueue.concurrentPerform(iterations: 5) { (i) in
                print("执行任务\(i+1)")
            }
            print("任务执行完成")
        }
    }
    
    //DispatchSemaphore
    
    func dispatchSemaphore() {
        var arr = [Int]()
        let semaphore = DispatchSemaphore.init(value: 1) // 创建信号量，控制同时访问资源的线程数为1
        for i in 0...100 {
            DispatchQueue.global().async {
                
                /*
                 其他并发操作
                 */
                
                semaphore.wait() // 如果信号量计数>=1,将信号量计数减1；如果信号量计数<1，阻塞线程直到信号量计数>=1
                arr.append(i)
                semaphore.signal() // 信号量计加1
                
                /*
                 其他并发操作
                 */
            }
        }
    }
    
    
    
    var shouldProduct = false;
    var shouldCustom = false;
    let cachePool = CachePool();
   
    
    @objc func startProduct()  {
//        let queue = DispatchQueue(label: "com.xianzhi.productqueue", qos: .default, attributes: .concurrent);
        
        if self.shouldProduct == true{
            return;
        }
        
        self.shouldProduct = true;
        DispatchQueue.global().async {
            
            repeat{
                self.product();
            
            }while(self.shouldProduct)
        }
        
        DispatchQueue.global().async {
            
            repeat{
                self.product();
                
            }while(self.shouldProduct)
        }
        
        DispatchQueue.global().async {
            
            repeat{
                self.product();
                
            }while(self.shouldProduct)
        }
        
        
    }
    
    @objc func endProduct()  {
        self.shouldProduct = false;
    }
    
    @objc func startCustom()  {
        
        if self.shouldCustom == true{
            return;
        }
        self.shouldCustom = true;
        DispatchQueue.global().async {
            repeat{
                self.custome();
            }while(self.shouldCustom)
            
        }
        
    }
    
    @objc func endCustom()  {
        self.shouldCustom = false;
    }
    
   
    
    
    func product() {
        
        let NwNumber2 = (arc4random() % 4) + 1
        Thread.sleep(forTimeInterval: TimeInterval(NwNumber2));
       
        let p = Product();
//        print("生产了一个产品");
        cachePool.add(p: p);
        
        
        
        
    }
    
    func custome()  {
        Thread.sleep(forTimeInterval: 1);
        cachePool.removeFist();
//        print("消费了一个产品");
        
    }
    
    
    
    
    

}

