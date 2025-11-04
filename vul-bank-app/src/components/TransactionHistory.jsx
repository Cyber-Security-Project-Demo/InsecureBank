import React, { useState, useEffect, useCallback } from 'react';
import { ArrowDown, ArrowUp, Send, DollarSign, FileText } from 'lucide-react';

const TransactionHistory = ({ userId }) => {
  const [transactions, setTransactions] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const fetchTransactions = useCallback(async () => {
    try {
      setLoading(true);
      // VULNERABLE: Direct user ID access - IDOR vulnerability
      const response = await fetch(`http://localhost:5000/api/transactions/${userId}`, {
        credentials: 'include'
      });

      if (response.ok) {
        const data = await response.json();
        setTransactions(data);
      } else {
        setError('Failed to fetch transactions');
      }
    } catch {
      setError('Network error occurred');
    } finally {
      setLoading(false);
    }
  }, [userId]);

  useEffect(() => {
    fetchTransactions();
  }, [fetchTransactions]);

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  const getTransactionIcon = (transaction) => {
    const { type, transaction_direction } = transaction;
    
    if (type === 'deposit') {
      return <ArrowDown className="w-6 h-6 text-green-600" />;
    } else if (type === 'withdraw') {
      return <ArrowUp className="w-6 h-6 text-red-600" />;
    } else if (type === 'transfer') {
      if (transaction_direction === 'incoming') {
        return <ArrowDown className="w-6 h-6 text-green-600" />;
      } else {
        return <Send className="w-6 h-6 text-blue-600" />;
      }
    }
    return <DollarSign className="w-6 h-6 text-gray-600" />;
  };

  const getTransactionDisplayText = (transaction) => {
    const { type, transaction_direction, recipient_username, sender_username } = transaction;
    
    if (type === 'deposit') {
      return 'Deposit';
    } else if (type === 'withdraw') {
      return 'Withdrawal';
    } else if (type === 'transfer') {
      if (transaction_direction === 'incoming') {
        return `Transfer from ${sender_username}`;
      } else {
        return `Transfer to ${recipient_username}`;
      }
    }
    return type;
  };

  const getAmountColor = (transaction) => {
    const { type, transaction_direction } = transaction;
    
    if (type === 'deposit' || (type === 'transfer' && transaction_direction === 'incoming')) {
      return 'text-green-600';
    } else {
      return 'text-red-600';
    }
  };

  const getAmountPrefix = (transaction) => {
    const { type, transaction_direction } = transaction;
    
    if (type === 'deposit' || (type === 'transfer' && transaction_direction === 'incoming')) {
      return '+';
    } else {
      return '-';
    }
  };

  if (loading) {
    return (
      <div className="flex justify-center items-center py-8">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex justify-end items-center">
        <button
          onClick={fetchTransactions}
          className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md text-sm font-medium transition duration-300"
        >
          Refresh
        </button>
      </div>

      {error && (
        <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded">
          {error}
        </div>
      )}

      <div className="space-y-4">
        {transactions.length === 0 ? (
          <div className="text-center py-8 text-gray-500">
            <FileText className="w-16 h-16 mx-auto mb-4 text-gray-400" />
            No transactions found
          </div>
        ) : (
          transactions.map((transaction) => (
              <div key={transaction.id} className="bg-white border border-gray-200 rounded-lg p-4 shadow-sm">
                <div className="flex items-center justify-between">
                  <div className="flex items-center space-x-4">
                    <div className="flex items-center justify-center">
                      {getTransactionIcon(transaction)}
                    </div>
                    <div>
                      <h3 className="font-semibold text-gray-900">
                        {getTransactionDisplayText(transaction)}
                      </h3>
                      <p className="text-sm text-gray-600">
                        {formatDate(transaction.created_at)}
                      </p>
                      {transaction.description && (
                        <p className="text-sm text-gray-500 mt-1">
                          {transaction.description}
                        </p>
                      )}
                    </div>
                  </div>
                  <div className="text-right">
                    <div className={`text-lg font-bold ${getAmountColor(transaction)}`}>
                      {getAmountPrefix(transaction)}${transaction.amount.toLocaleString()}
                    </div>
                    <div className="text-sm text-gray-500">
                      ID: {transaction.id}
                    </div>
                    <div className="text-xs text-gray-400">
                      {transaction.transaction_direction === 'incoming' ? 'Received' : 'Sent'}
                    </div>
                  </div>
                </div>
              </div>
          ))
        )}
      </div>
    </div>
  );
};

export default TransactionHistory;