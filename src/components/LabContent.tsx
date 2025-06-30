import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Separator } from '@/components/ui/separator';
import { 
  Clock, 
  User, 
  Tag, 
  ArrowLeft, 
  ArrowRight, 
  Copy, 
  Terminal,
  AlertTriangle,
  Info,
  CheckCircle
} from 'lucide-react';
import { Lab, LabSection } from '@/types/lab';

interface LabContentProps {
  lab: Lab;
  onPrevious?: () => void;
  onNext?: () => void;
  onBack: () => void;
}

const LabContent: React.FC<LabContentProps> = ({ lab, onPrevious, onNext, onBack }) => {
  const copyToClipboard = (text: string) => {
    navigator.clipboard.writeText(text);
  };

  const renderSection = (section: LabSection) => {
    switch (section.type) {
      case 'code':
        return (
          <div className="relative group">
            <pre className="bg-gray-900 text-gray-100 p-4 rounded-lg overflow-x-auto">
              <code className={`language-${section.language || 'bash'}`}>
                {section.content}
              </code>
            </pre>
            <Button
              size="sm"
              variant="outline"
              className="absolute top-2 right-2 opacity-0 group-hover:opacity-100 transition-opacity"
              onClick={() => copyToClipboard(section.content)}
            >
              <Copy className="w-4 h-4" />
            </Button>
          </div>
        );

      case 'command':
        return (
          <div className="relative group">
            <div className="bg-gray-800 text-green-400 p-4 rounded-lg font-mono text-sm border-l-4 border-green-400">
              <div className="flex items-center gap-2 mb-2">
                <Terminal className="w-4 h-4" />
                <span className="text-gray-300">Command</span>
              </div>
              <code>{section.content}</code>
            </div>
            <Button
              size="sm"
              variant="outline"
              className="absolute top-2 right-2 opacity-0 group-hover:opacity-100 transition-opacity"
              onClick={() => copyToClipboard(section.content)}
            >
              <Copy className="w-4 h-4" />
            </Button>
          </div>
        );

      case 'warning':
        return (
          <div className="bg-yellow-50 border-l-4 border-yellow-400 p-4 rounded-r-lg dark:bg-yellow-900/20 dark:border-yellow-500">
            <div className="flex items-center gap-2 mb-2">
              <AlertTriangle className="w-5 h-5 text-yellow-600 dark:text-yellow-400" />
              <span className="font-medium text-yellow-800 dark:text-yellow-200">Warning</span>
            </div>
            <div className="text-yellow-700 dark:text-yellow-300 prose prose-sm max-w-none">
              {section.content}
            </div>
          </div>
        );

      case 'info':
        return (
          <div className="bg-blue-50 border-l-4 border-blue-400 p-4 rounded-r-lg dark:bg-blue-900/20 dark:border-blue-500">
            <div className="flex items-center gap-2 mb-2">
              <Info className="w-5 h-5 text-blue-600 dark:text-blue-400" />
              <span className="font-medium text-blue-800 dark:text-blue-200">Info</span>
            </div>
            <div className="text-blue-700 dark:text-blue-300 prose prose-sm max-w-none">
              {section.content}
            </div>
          </div>
        );

      case 'image':
        return (
          <div className="text-center">
            <img 
              src={section.imageUrl} 
              alt={section.title}
              className="max-w-full h-auto rounded-lg shadow-md mx-auto"
            />
            {section.title && (
              <p className="text-sm text-gray-600 dark:text-gray-400 mt-2 italic">
                {section.title}
              </p>
            )}
          </div>
        );

      default: // text
        return (
          <div className="prose prose-gray dark:prose-invert max-w-none">
            <div dangerouslySetInnerHTML={{ __html: section.content }} />
          </div>
        );
    }
  };

  return (
    <div className="max-w-4xl mx-auto p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center gap-4 mb-6">
        <Button variant="outline" onClick={onBack}>
          <ArrowLeft className="w-4 h-4 mr-2" />
          Back to Labs
        </Button>
      </div>

      <Card>
        <CardHeader>
          <div className="space-y-4">
            <CardTitle className="text-2xl font-bold text-gray-900 dark:text-gray-100">
              {lab.title}
            </CardTitle>
            
            {/* Metadata */}
            <div className="flex flex-wrap items-center gap-4">
              <Badge variant="outline" className="px-3 py-1">
                {lab.category}
              </Badge>
              <div className="flex items-center gap-1 text-sm text-gray-500">
                <Clock className="w-4 h-4" />
                <span>{lab.duration}</span>
              </div>
              {lab.author && (
                <div className="flex items-center gap-1 text-sm text-gray-500">
                  <User className="w-4 h-4" />
                  <span>{lab.author}</span>
                </div>
              )}
            </div>

            {/* Tags */}
            <div className="flex items-center gap-2 flex-wrap">
              <Tag className="w-4 h-4 text-gray-400" />
              {lab.tags.map((tag, index) => (
                <Badge key={index} variant="secondary" className="text-xs">
                  {tag}
                </Badge>
              ))}
            </div>

            {/* Prerequisites */}
            {lab.prerequisites && lab.prerequisites.length > 0 && (
              <div className="bg-gray-50 dark:bg-gray-800/50 p-3 rounded-lg">
                <span className="font-medium text-sm text-gray-700 dark:text-gray-300">
                  Prerequisites: 
                </span>
                <span className="text-sm text-gray-600 dark:text-gray-400 ml-2">
                  {lab.prerequisites.join(', ')}
                </span>
              </div>
            )}

            <p className="text-gray-600 dark:text-gray-400">
              {lab.description}
            </p>
          </div>
        </CardHeader>

        <CardContent>
          <div className="space-y-6">
            {lab.sections.map((section, index) => (
              <div key={section.id}>
                {section.title && (
                  <h3 className="text-lg font-semibold text-gray-900 dark:text-gray-100 mb-3">
                    {section.title}
                  </h3>
                )}
                {renderSection(section)}
                {index < lab.sections.length - 1 && <Separator className="my-6" />}
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      {/* Navigation */}
      <div className="flex justify-between items-center">
        <div>
          {lab.previousLab && onPrevious && (
            <Button variant="outline" onClick={onPrevious}>
              <ArrowLeft className="w-4 h-4 mr-2" />
              Previous Lab
            </Button>
          )}
        </div>
        <div>
          {lab.nextLab && onNext && (
            <Button onClick={onNext}>
              Next Lab
              <ArrowRight className="w-4 h-4 ml-2" />
            </Button>
          )}
        </div>
      </div>
    </div>
  );
};

export default LabContent;
