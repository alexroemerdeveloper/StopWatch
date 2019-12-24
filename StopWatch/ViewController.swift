//
//  ViewController.swift
//  StopWatch
//
//  Created by Alexander Römer on 21.12.19.
//  Copyright © 2019 Alexander Römer. All rights reserved.
//

import UIKit

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var stopwatchButtons: [UIButton]!
    
    private var seconds = 0
    private var running = false
    private var timer = Timer()
    
    private var roundTimes = [String]()
    private let formatter  = DateComponentsFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Did Load")
        // Do any additional setup after loading the view.
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        updateTimeLabel()
        tableView.dataSource = self
        stopwatchButtons = stopwatchButtons.sorted { $0.tag < $1.tag }
        tableView.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.2862745098, blue: 0.368627451, alpha: 1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         print("Will Appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         print("Did Appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
         print("Will Disapear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
         print("Did Disapear")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    private func updateTimeLabel() {
        if let formattedString = formatter.string(from: TimeInterval(seconds)) {
            timeLabel.text = formattedString
        }
    }
    
    @objc func countUp() {
        seconds += 1
        updateTimeLabel()
    }
    
    private func startTimer() {
        if running { return }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countUp), userInfo: nil, repeats: true)
        running = true
    }
    
    private func stopTimer() {
        timer.invalidate()
        running = false
    }
    
    private func resetTimer() {
        stopTimer()
        seconds = 0
        updateTimeLabel()
        roundTimes.removeAll()
        tableView.reloadData()
        
        set(title: "Start", for: 0)
        set(title: "Stop", for: 1)
    }
    
    private func set(title: String, for buttonIndex: Int) {
        stopwatchButtons[buttonIndex].setTitle(title, for: .normal)
    }
    
    
    @IBAction func buttonHandler(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            switch title {
            case "Start":
                startTimer()
                set(title: "Round", for: 0)
                set(title: "Stop", for: 1)
            case "Stop":
                stopTimer()
                set(title: "Start", for: 0)
                set(title: "Reset", for: 1)
            case "Round":
                if let time = timeLabel.text {
                    roundTimes.append(time)
                    tableView.reloadData()
                }
            case "Reset":
                resetTimer()
            default:
                break
            }
        }
    }
    
    
    
    private func layout() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
}
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roundTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoundTableViewCell", for: indexPath)
        cell.textLabel?.text = roundTimes[indexPath.row]
        return cell
    }
}

