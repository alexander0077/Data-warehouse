using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.ComponentModel;
using System.Globalization;
using System.IO;
using System.Threading;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.Window;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using System.Net;
using System.Runtime.InteropServices;
using System.DirectoryServices.ActiveDirectory;

namespace lab5
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : System.Windows.Window
    {
        public int procentFIBO = 0;


        public MainWindow()
        {
            InitializeComponent();
        }


        private void NumberValidationTextBox(object sender, TextCompositionEventArgs e)
        {
            Regex regex = new Regex("[^0-9]+");
            e.Handled = regex.IsMatch(e.Text);
        }

        private void bClickNewtonTask(object sender, RoutedEventArgs e)
        {
            int k, n;
            if (!Int32.TryParse(N.Text, out n) || !Int32.TryParse(K.Text, out k))
            {
                System.Windows.MessageBox.Show("Aby obliczyć wartość Symbolu Newtona musisz najpierw ustawić n i k!", "Error", System.Windows.MessageBoxButton.OK);
                return;
            }
            NewtonSymbol tmp = new NewtonSymbol(n, k);
            double wynik = tmp.NewtonTasks();
            if (wynik < 0) {
                System.Windows.MessageBox.Show("Podano zle wartosci k, n!", "Error", System.Windows.MessageBoxButton.OK);
                return;
            }
            Tasks.Text = wynik.ToString();
        }

        private void bClickNewtonDelegates(object sender, RoutedEventArgs e)
        {
            int k, n;
            if (!Int32.TryParse(N.Text, out n) || !Int32.TryParse(K.Text, out k))
            {
                System.Windows.MessageBox.Show("Aby obliczyć wartość Symbolu Newtona musisz najpierw ustawić n i k!", "Error", System.Windows.MessageBoxButton.OK);
                return;
            }
            NewtonSymbol tmp = new NewtonSymbol(n, k);
            double wynik = tmp.NewtonDele();
            if (wynik < 0)
            {
                System.Windows.MessageBox.Show("Podano zle wartosci k, n!", "Error", System.Windows.MessageBoxButton.OK);
                return;
            }
            Delegates.Text = wynik.ToString();
        }

        private void bClickNewtonAsync(object sender, RoutedEventArgs e)
        {
            int k, n;
            if (!Int32.TryParse(N.Text, out n) || !Int32.TryParse(K.Text, out k))
            {
                System.Windows.MessageBox.Show("Aby obliczyć wartość Symbolu Newtona musisz najpierw ustawić n i k!", "Error", System.Windows.MessageBoxButton.OK);
                return;
            }
            NewtonSymbol tmp = new NewtonSymbol(n, k);
            double wynik = tmp.NewtonAsync().Result;
            if (wynik < 0)
            {
                System.Windows.MessageBox.Show("Podano zle wartosci k, n!", "Error", System.Windows.MessageBoxButton.OK);
                return;
            }
            Async.Text = wynik.ToString();
        }

        private void bClickGetFibbonacci(object sender, RoutedEventArgs e)
        {
            int i;
            if (!Int32.TryParse(FIBOi.Text, out i))
            {
                System.Windows.MessageBox.Show("Musisz podac i!", "Error", System.Windows.MessageBoxButton.OK);
                return;
            }

            if (i <= 0)
            {
                System.Windows.MessageBox.Show("I musi byc wieksze od 0!", "Error", System.Windows.MessageBoxButton.OK);
                return;
            }
            BackgroundWorker calcFIBOworker = new BackgroundWorker();
            calcFIBOworker.DoWork += calcFIBOworker_DoWork;
            calcFIBOworker.RunWorkerCompleted += calcFIBOworker_RunWorkerCompleted;
            calcFIBOworker.ProgressChanged += calcFIBOworker_ProgressChanged;
            procentFIBO = 0;
            FIBOprogers.Value = 0;
            calcFIBOworker.RunWorkerAsync(i);
        }
        //TU METODY DO BGW
        private void calcFIBOworker_DoWork(object sender, DoWorkEventArgs e)
        {
            BackgroundWorker worker = sender as BackgroundWorker;
            if (worker != null)
            {
                worker.WorkerReportsProgress = true;
                e.Result = ComputeFibonacci((int)e.Argument, worker, e);
            }
        }
        private UInt64 ComputeFibonacci(int n, BackgroundWorker worker, DoWorkEventArgs e)
        {
            UInt64 fibonacci = 0;
            if (worker.CancellationPending)
            {
                e.Cancel = true;
            }
            else
            {
                UInt64 f1 = 1;
                UInt64 f2 = 1;
                UInt64 tmp;
                for (int i = 1;i<n-1;i++){
                    tmp = f1 + f2;
                    f1 = f2;
                    f2 = tmp;
                    int percentComplete = (int)((float)i / (n-2) * 100);
                    if (percentComplete > procentFIBO)
                    {
                        procentFIBO = percentComplete;
                        worker.ReportProgress(percentComplete);
                        Thread.Sleep(20);
                    }
                    fibonacci = f2;
                }
            }
            return fibonacci;
        }
        private void calcFIBOworker_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            FIBOresult.Text = e.Result.ToString();
        }

        private void calcFIBOworker_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            FIBOprogers.Value = e.ProgressPercentage;
        }
        private void bClickResolveDNS(object sender, EventArgs e)
        {
            List<Tuple<string, string>> result = new List<Tuple<string, string>>();
            string[] hostNames = { "www.microsoft.com", "www.apple.com",
"www.google.com", "www.ibm.com", "cisco.netacad.net",
"www.oracle.com", "www.nokia.com", "www.hp.com", "www.dell.com",
"www.samsung.com", "www.toshiba.com", "www.siemens.com",
"www.amazon.com", "www.sony.com", "www.canon.com", "www.al-enterprise.com", "www.acer.com", "www.motorola.com" };
            hostNames.AsParallel()
                .ForAll(hostName =>
                {
                    lock (result)
                    {
                        result.Add(Tuple.Create(hostName, Dns.GetHostAddresses(hostName).First().ToString()));
                    }
                });
            foreach(var adres in result)
            {
                DNS_OUTPUT.Text +=  $"{adres.Item1} => {adres.Item2}\n\n";
            }
        }
    }


    class NewtonSymbol
    {
        public int K { get; set; }
        public int N { get; set; }
        public NewtonSymbol(int n, int k) { 
            N = n;
            K = k;
        }

        private double obliczLicznik()
        {
            double tooRet = 1;
            for (int i = (N - K + 1); i <= N; i++)
            {
                tooRet *= i;
            }
            return tooRet;
        }

        private double obliczMianownik()
        {
            double tooRet = 1;
            for (int i = 1; i< K + 1; i++) {
                tooRet *= i;
            }
            return tooRet;
        }

        public double NewtonTasks()
        {
            if (N <= 0 || K <= 0 || N < K) return -1;

            Task<double> licznikTask = Task.Factory.StartNew<double>(
                (obj) => obliczLicznik(),
                100 //state
                );

            Task<double> mianownikTask = Task.Factory.StartNew<double>(
                (obj) => obliczMianownik(),
                100 //state
                );
            Task.WaitAll( licznikTask, mianownikTask );
            return licznikTask.Result / mianownikTask.Result;
        }
    
        public double NewtonDele()
        {
            //NIE DZIALA POWYZEJ DOTNET 4.5 
            Func<double> deleLicznik = obliczLicznik;
            Func<double> deleMianownik = obliczMianownik;
            IAsyncResult licznik, mianownik;
            licznik = deleLicznik.BeginInvoke(null,null);
            mianownik = deleMianownik.BeginInvoke(null,null);
            while(licznik.IsCompleted == false && mianownik.IsCompleted == false)
            {
                Console.WriteLine("KOCHAM PR");
            }
            double wynik = deleLicznik.EndInvoke(licznik)/deleMianownik.EndInvoke(mianownik);
            return wynik;
        }

        public async Task<double> NewtonAsync()
        {
            var licznik = Task.Run(obliczLicznik);
            var mianownik = Task.Run(obliczMianownik);

            await Task.WhenAll(licznik, mianownik);

            return licznik.Result/mianownik.Result;
        }
    }
}
